# Setup And Dependencies

## Archived Local Sources

- Notebook: [sources/upstream/isi-dev/ComfyUI_LTX2_3_TI2V.ipynb](../sources/upstream/isi-dev/ComfyUI_LTX2_3_TI2V.ipynb)
- App JSON: [sources/upstream/isi-dev/LTX_2.3_Image_or_Text_&_Audio_2_Video_App_V3.json](../sources/upstream/isi-dev/LTX_2.3_Image_or_Text_&_Audio_2_Video_App_V3.json)

## Supported Execution Paths

- Colab-first path
  - The notebook clones `ComfyUI`, installs Python requirements, installs apt package `aria2`, downloads models, and launches ComfyUI.
- Existing ComfyUI path
  - Use the archived app JSON directly, but only after matching the same custom nodes and model files.

## Notebook Toggles

From the archived notebook:

- `offload_models_for_low_VRAM = True`
- `include_manager = False`
- `include_ltxNodes = True`
- `include_rgthree = True`
- `include_Easy_Use = True`
- `include_VideoHelperSuite = True`
- `include_MelBandRoFormer = True`

Low-VRAM mode launches ComfyUI with `python main.py --cache-none --dont-print-server`.

## Required Custom Nodes

- `ComfyUI-KJNodes`
- `ComfyUI-GGUF`
- `ComfyUI-LTXVideo`
- `rgthree-comfy`
- `ComfyUI-Easy-Use`
- `ComfyUI-VideoHelperSuite`
- `ComfyUI-MelBandRoFormer`

Optional:

- `ComfyUI-Manager`

## Model Files Seen In The Notebook And Workflow

### Core LTX stack

- `models/unet/ltx-2.3-22b-dev-Q4_K_M.gguf`
- `models/text_encoders/gemma_3_12B_it_fp8_scaled.safetensors`
- `models/text_encoders/mmproj-BF16.gguf`
- `models/text_encoders/ltx-2.3-22b-dev_embeddings_connectors.safetensors`
- `models/vae/ltx-2.3-22b-dev_video_vae.safetensors`
- `models/vae/ltx-2.3-22b-dev_audio_vae.safetensors`
- `models/latent_upscale_models/ltx-2.3-spatial-upscaler-x2-1.0.safetensors`
- `models/vae/taeltx2_3.safetensors`

### LoRA

- Default downloaded LoRA:
  - `ltx-2.3-22b-distilled-lora-384.safetensors`
- Extra LoRA slots:
  - up to 4 download toggles are present in the notebook

### Custom audio support

- `models/diffusion_models/MelBandRoformer_fp16.safetensors`

## Launch Modes In The Notebook

- Default Colab native port forwarding
- Cloudflare tunnel
- ngrok tunnel
- In-cell iframe view

The notebook defaults to the native Colab link flow when the others are disabled.

## Operational Caveats

- The notebook markdown says to upload an image even for text-to-video to avoid errors.
- The app JSON includes both custom-audio and LTX-audio paths. Keep the switch state aligned with the presence or absence of an uploaded audio file.
- The prompt enhancer is optional and depends on the loaded Gemma-side text stack being healthy.
