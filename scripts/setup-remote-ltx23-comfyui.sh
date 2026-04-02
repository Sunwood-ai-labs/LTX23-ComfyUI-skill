#!/usr/bin/env bash
set -euo pipefail

INSTALL_DIR="/content/ComfyUI"
INCLUDE_MANAGER=0
DOWNLOAD_MODELS=1
DOWNLOAD_LORA=1
DRY_RUN=0

usage() {
  cat <<'EOF'
Usage: setup-remote-ltx23-comfyui.sh [options]

Options:
  --install-dir PATH     Target ComfyUI directory. Default: /content/ComfyUI
  --include-manager      Clone and install ComfyUI-Manager
  --skip-models          Skip model downloads
  --skip-lora            Skip the default distilled LoRA download
  --dry-run              Print actions without executing them
  -h, --help             Show this help
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --install-dir)
      INSTALL_DIR="$2"
      shift 2
      ;;
    --include-manager)
      INCLUDE_MANAGER=1
      shift
      ;;
    --skip-models)
      DOWNLOAD_MODELS=0
      shift
      ;;
    --skip-lora)
      DOWNLOAD_LORA=0
      shift
      ;;
    --dry-run)
      DRY_RUN=1
      shift
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $1" >&2
      usage >&2
      exit 1
      ;;
  esac
done

log() {
  printf '[setup] %s\n' "$*"
}

run_cmd() {
  if [[ "$DRY_RUN" -eq 1 ]]; then
    printf '[dry-run]'
    printf ' %q' "$@"
    printf '\n'
    return 0
  fi
  "$@"
}

have_sudo() {
  sudo -n true >/dev/null 2>&1
}

run_pip() {
  run_cmd python3 -m pip "$@"
}

ensure_parent_writable() {
  local target="$1"
  local parent
  parent="$(dirname "$target")"

  if [[ ! -d "$parent" ]]; then
    if [[ "$DRY_RUN" -eq 1 ]]; then
      if have_sudo; then
        run_cmd sudo mkdir -p "$parent"
      else
        run_cmd mkdir -p "$parent"
      fi
    elif ! mkdir -p "$parent" 2>/dev/null; then
      if have_sudo; then
        run_cmd sudo mkdir -p "$parent"
      else
        echo "Cannot create $parent and sudo is unavailable." >&2
        exit 1
      fi
    fi
  fi

  if [[ ! -w "$parent" ]]; then
    if have_sudo; then
      run_cmd sudo chown "$(id -u):$(id -g)" "$parent"
    else
      echo "Parent directory is not writable: $parent" >&2
      exit 1
    fi
  fi
}

ensure_ld_library_path() {
  export LD_LIBRARY_PATH="/usr/lib64-nvidia:${LD_LIBRARY_PATH:-}"
  if ! grep -Fq '/usr/lib64-nvidia' "$HOME/.bashrc" 2>/dev/null; then
    if [[ "$DRY_RUN" -eq 1 ]]; then
      log "would append LD_LIBRARY_PATH fix to ~/.bashrc"
    else
      printf '\nexport LD_LIBRARY_PATH=/usr/lib64-nvidia:${LD_LIBRARY_PATH:-}\n' >> "$HOME/.bashrc"
    fi
  fi
}

ensure_pip_env() {
  export PIP_CONFIG_FILE=/dev/null
  export PIP_DISABLE_PIP_VERSION_CHECK=1
  export PIP_ROOT_USER_ACTION=ignore
}

ensure_aria2() {
  if command -v aria2c >/dev/null 2>&1 && command -v git >/dev/null 2>&1; then
    return
  fi
  if have_sudo; then
    run_cmd sudo apt-get update -qq
    run_cmd sudo apt-get install -y -qq aria2 git
    return
  fi
  echo "aria2c or git is missing and sudo is unavailable." >&2
  exit 1
}

move_path() {
  local src="$1"
  local dst="$2"
  if [[ "$DRY_RUN" -eq 1 ]]; then
    run_cmd mv "$src" "$dst"
    return
  fi
  if mv "$src" "$dst" 2>/dev/null; then
    return
  fi
  if have_sudo; then
    run_cmd sudo mv "$src" "$dst"
    return
  fi
  echo "Could not move $src to $dst" >&2
  exit 1
}

remove_empty_dir() {
  local path="$1"
  if [[ "$DRY_RUN" -eq 1 ]]; then
    run_cmd rmdir "$path"
    return
  fi
  if rmdir "$path" 2>/dev/null; then
    return
  fi
  if have_sudo; then
    run_cmd sudo rmdir "$path"
    return
  fi
  echo "Could not remove empty dir: $path" >&2
  exit 1
}

clone_or_update() {
  local url="$1"
  local dir="$2"
  if [[ -d "$dir/.git" ]]; then
    run_cmd git -C "$dir" pull --ff-only
  else
    if [[ -d "$dir" ]]; then
      if [[ -z "$(ls -A "$dir" 2>/dev/null)" ]]; then
        remove_empty_dir "$dir"
      else
        local backup_dir
        backup_dir="${dir}.stale.$(date +%Y%m%d-%H%M%S)"
        log "moving stale custom-node dir to $backup_dir"
        move_path "$dir" "$backup_dir"
      fi
    fi
    run_cmd git clone "$url" "$dir"
  fi
}

install_requirements() {
  local path="$1"
  if [[ -f "$path" ]]; then
    run_pip install -r "$path"
  fi
}

download_file() {
  local url="$1"
  local dest_dir="$2"
  local filename="$3"
  run_cmd mkdir -p "$dest_dir"
  if [[ -s "$dest_dir/$filename" ]]; then
    log "skip existing $filename"
    return
  fi
  run_cmd aria2c --console-log-level=error -c -x 16 -s 16 -k 1M "$url" -d "$dest_dir" -o "$filename"
}

install_python_stack() {
  run_pip install torch torchvision
  run_pip install -q torchsde einops diffusers accelerate
  run_pip install av spandrel albumentations onnx opencv-python onnxruntime
}

install_comfyui() {
  if [[ -d "$INSTALL_DIR/.git" ]]; then
    git -C "$INSTALL_DIR" pull --ff-only || true
  else
    if [[ -d "$INSTALL_DIR" && -n "$(ls -A "$INSTALL_DIR" 2>/dev/null)" ]]; then
      if [[ -f "$INSTALL_DIR/main.py" ]]; then
        log "reusing existing ComfyUI tree without git metadata: $INSTALL_DIR"
      else
        local backup_dir
        backup_dir="${INSTALL_DIR}.stale.$(date +%Y%m%d-%H%M%S)"
        log "moving stale install dir to $backup_dir"
        move_path "$INSTALL_DIR" "$backup_dir"
      fi
    fi
    if [[ ! -f "$INSTALL_DIR/main.py" ]]; then
      git clone https://github.com/comfyanonymous/ComfyUI "$INSTALL_DIR"
    fi
  fi
  install_requirements "$INSTALL_DIR/requirements.txt"
}

install_custom_nodes() {
  local custom_nodes_dir="$INSTALL_DIR/custom_nodes"
  mkdir -p "$custom_nodes_dir"

  clone_or_update https://github.com/kijai/ComfyUI-KJNodes "$custom_nodes_dir/ComfyUI-KJNodes"
  clone_or_update https://github.com/city96/ComfyUI-GGUF "$custom_nodes_dir/ComfyUI-GGUF"
  clone_or_update https://github.com/Lightricks/ComfyUI-LTXVideo "$custom_nodes_dir/ComfyUI-LTXVideo"
  clone_or_update https://github.com/rgthree/rgthree-comfy.git "$custom_nodes_dir/rgthree-comfy"
  clone_or_update https://github.com/yolain/ComfyUI-Easy-Use "$custom_nodes_dir/ComfyUI-Easy-Use"
  clone_or_update https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite "$custom_nodes_dir/ComfyUI-VideoHelperSuite"
  clone_or_update https://github.com/kijai/ComfyUI-MelBandRoFormer "$custom_nodes_dir/ComfyUI-MelBandRoFormer"

  if [[ "$INCLUDE_MANAGER" -eq 1 ]]; then
    clone_or_update https://github.com/Comfy-Org/ComfyUI-Manager "$custom_nodes_dir/ComfyUI-Manager"
  fi

  install_requirements "$custom_nodes_dir/ComfyUI-KJNodes/requirements.txt"
  install_requirements "$custom_nodes_dir/ComfyUI-GGUF/requirements.txt"
  install_requirements "$custom_nodes_dir/ComfyUI-Easy-Use/requirements.txt"
  install_requirements "$custom_nodes_dir/ComfyUI-VideoHelperSuite/requirements.txt"
  install_requirements "$custom_nodes_dir/ComfyUI-MelBandRoFormer/requirements.txt"

  if [[ "$INCLUDE_MANAGER" -eq 1 ]]; then
    install_requirements "$custom_nodes_dir/ComfyUI-Manager/requirements.txt"
  fi
}

download_models() {
  local models_dir="$INSTALL_DIR/models"

  download_file "https://huggingface.co/unsloth/LTX-2.3-GGUF/resolve/main/ltx-2.3-22b-dev-Q4_K_M.gguf" "$models_dir/unet" "ltx-2.3-22b-dev-Q4_K_M.gguf"
  download_file "https://huggingface.co/Comfy-Org/ltx-2/resolve/main/split_files/text_encoders/gemma_3_12B_it_fp8_scaled.safetensors" "$models_dir/text_encoders" "gemma_3_12B_it_fp8_scaled.safetensors"
  download_file "https://huggingface.co/unsloth/gemma-3-12b-it-qat-GGUF/resolve/main/mmproj-BF16.gguf" "$models_dir/text_encoders" "mmproj-BF16.gguf"
  download_file "https://huggingface.co/unsloth/LTX-2.3-GGUF/resolve/main/text_encoders/ltx-2.3-22b-dev_embeddings_connectors.safetensors" "$models_dir/text_encoders" "ltx-2.3-22b-dev_embeddings_connectors.safetensors"
  download_file "https://huggingface.co/unsloth/LTX-2.3-GGUF/resolve/main/vae/ltx-2.3-22b-dev_video_vae.safetensors" "$models_dir/vae" "ltx-2.3-22b-dev_video_vae.safetensors"
  download_file "https://huggingface.co/unsloth/LTX-2.3-GGUF/resolve/main/vae/ltx-2.3-22b-dev_audio_vae.safetensors" "$models_dir/vae" "ltx-2.3-22b-dev_audio_vae.safetensors"
  download_file "https://huggingface.co/Lightricks/LTX-2.3/resolve/main/ltx-2.3-spatial-upscaler-x2-1.0.safetensors" "$models_dir/latent_upscale_models" "ltx-2.3-spatial-upscaler-x2-1.0.safetensors"
  download_file "https://huggingface.co/Kijai/LTX2.3_comfy/resolve/main/vae/taeltx2_3.safetensors" "$models_dir/vae" "taeltx2_3.safetensors"
  download_file "https://huggingface.co/Kijai/MelBandRoFormer_comfy/resolve/main/MelBandRoformer_fp16.safetensors" "$models_dir/diffusion_models" "MelBandRoformer_fp16.safetensors"

  if [[ "$DOWNLOAD_LORA" -eq 1 ]]; then
    download_file "https://huggingface.co/Lightricks/LTX-2.3/resolve/main/ltx-2.3-22b-distilled-lora-384.safetensors" "$models_dir/loras" "ltx-2.3-22b-distilled-lora-384.safetensors"
  fi
}

verify_gpu() {
  if [[ "$DRY_RUN" -eq 1 ]]; then
    log "would verify torch CUDA visibility"
    return
  fi
  python3 - <<'PY'
import torch
print('cuda_available', torch.cuda.is_available())
print('device_name', torch.cuda.get_device_name(0) if torch.cuda.is_available() else 'NO_GPU')
PY
}

main() {
  ensure_ld_library_path
  ensure_pip_env
  ensure_parent_writable "$INSTALL_DIR"
  ensure_aria2

  log "install dir: $INSTALL_DIR"
  log "installing python stack"
  install_python_stack

  log "installing ComfyUI"
  install_comfyui

  log "installing custom nodes"
  install_custom_nodes

  if [[ "$DOWNLOAD_MODELS" -eq 1 ]]; then
    log "downloading models"
    download_models
  else
    log "skipping model downloads"
  fi

  log "verifying GPU visibility"
  verify_gpu

  cat <<EOF

Setup complete.

Install dir:
  $INSTALL_DIR

Suggested next step:
  cd "$INSTALL_DIR" && python3 main.py --listen 0.0.0.0 --port 8188 --cache-none --dont-print-server
EOF
}

main "$@"
