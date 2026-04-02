#!/usr/bin/env bash
set -euo pipefail

INSTALL_DIR="/content/ComfyUI"
PORT=8188
LOW_VRAM=1
RESTART=0

usage() {
  cat <<'EOF'
Usage: start-remote-comfyui.sh [options]

Options:
  --install-dir PATH   Target ComfyUI directory. Default: /content/ComfyUI
  --port PORT          ComfyUI port. Default: 8188
  --no-low-vram        Start without --cache-none
  --restart            Stop matching main.py processes before starting
  -h, --help           Show this help
EOF
}

while [[ $# -gt 0 ]]; do
  case "$1" in
    --install-dir)
      INSTALL_DIR="$2"
      shift 2
      ;;
    --port)
      PORT="$2"
      shift 2
      ;;
    --no-low-vram)
      LOW_VRAM=0
      shift
      ;;
    --restart)
      RESTART=1
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

export LD_LIBRARY_PATH="/usr/lib64-nvidia:${LD_LIBRARY_PATH:-}"
export PIP_CONFIG_FILE=/dev/null
export PIP_DISABLE_PIP_VERSION_CHECK=1
export PYTORCH_CUDA_ALLOC_CONF="expandable_segments:True"

if [[ ! -d "$INSTALL_DIR" ]]; then
  echo "Install dir does not exist: $INSTALL_DIR" >&2
  exit 1
fi

cd "$INSTALL_DIR"

if [[ "$RESTART" -eq 1 ]]; then
  pkill -f "python3 main.py" || true
  sleep 2
fi

cmd=(python3 main.py --listen 0.0.0.0 --port "$PORT" --dont-print-server)
if [[ "$LOW_VRAM" -eq 1 ]]; then
  cmd+=(--cache-none)
fi

nohup "${cmd[@]}" > "$INSTALL_DIR/comfyui.log" 2>&1 &
pid=$!

python3 - <<PY
import socket
import sys
import time

host = "127.0.0.1"
port = int("$PORT")
deadline = time.time() + 60

while time.time() < deadline:
    sock = socket.socket()
    sock.settimeout(1)
    try:
        sock.connect((host, port))
        print("comfyui_port_open", port)
        sys.exit(0)
    except OSError:
        time.sleep(1)
    finally:
        sock.close()

print("comfyui_port_failed", port)
sys.exit(1)
PY

echo "comfyui_pid $pid"
echo "comfyui_log $INSTALL_DIR/comfyui.log"
