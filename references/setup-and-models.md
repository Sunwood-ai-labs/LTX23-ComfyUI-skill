# Setup and Models

## Preserved Upstream Artifacts

- `sources/upstream/isi-dev/LTX_2.3_Image_or_Text_&_Audio_2_Video_App_V3.json`
- `sources/upstream/isi-dev/ComfyUI_LTX2_3_TI2V.ipynb`

Treat these as immutable references. If you need to modify the workflow, work on a copy and keep the upstream originals intact.

## Notebook Toggles

The archived notebook exposes these booleans near the top:

- `offload_models_for_low_VRAM = True`
- `include_manager = False`
- `include_ltxNodes = True`
- `include_rgthree = True`
- `include_Easy_Use = True`
- `include_VideoHelperSuite = True`
- `include_MelBandRoFormer = True`

For the provided App V3 workflow, everything except `ComfyUI-Manager` should be treated as required unless you have direct proof otherwise.

## Environment Bootstrap from the Notebook

The notebook installs:

- `torch`, `torchvision`
- `torchsde`, `einops`, `diffusers`, `accelerate`
- `av`, `spandrel`, `albumentations`, `onnx`, `opencv-python`, `onnxruntime`
- `ComfyUI` itself from `comfyanonymous/ComfyUI`

Then it clones these custom-node repositories:

- `kijai/ComfyUI-KJNodes`
- `city96/ComfyUI-GGUF`
- `Lightricks/ComfyUI-LTXVideo`
- `rgthree/rgthree-comfy`
- `yolain/ComfyUI-Easy-Use`
- `Kosinkadink/ComfyUI-VideoHelperSuite`
- `kijai/ComfyUI-MelBandRoFormer`

Optional:

- `ComfyUI-Manager`

If the workflow imports with missing nodes, check these first.

## Models Downloaded in the Notebook

| File | Target directory in the notebook | Notes |
| --- | --- | --- |
| `ltx-2.3-22b-dev-Q4_K_M.gguf` | `models/unet` | Core GGUF UNet |
| `gemma_3_12B_it_fp8_scaled.safetensors` | `models/text_encoders` | Text encoder |
| `mmproj-BF16.gguf` | `models/text_encoders` | Notebook helper asset |
| `ltx-2.3-22b-dev_embeddings_connectors.safetensors` | `models/text_encoders` | LTX connector embeddings |
| `ltx-2.3-22b-dev_video_vae.safetensors` | `models/vae` | Video VAE |
| `ltx-2.3-22b-dev_audio_vae.safetensors` | `models/vae` | Audio VAE |
| `ltx-2.3-spatial-upscaler-x2-1.0.safetensors` | `models/latent_upscale_models` | Second-pass latent upscaler |
| `taeltx2_3.safetensors` | `models/vae` | Tiny preview VAE |
| `MelBandRoformer_fp16.safetensors` | `models/diffusion_models` | Optional vocal isolation model |
| `ltx-2.3-22b-distilled-lora-384.safetensors` | `models/loras` | Optional distilled LoRA |

## Model Files Visible in the Workflow JSON

The graph references these filenames directly:

- `ltx-2.3-22b-dev-Q4_K_M.gguf`
- `ltx-2.3-22b-dev_video_vae.safetensors`
- `ltx-2.3-22b-dev_audio_vae.safetensors`
- `gemma_3_12B_it_fp8_scaled.safetensors`
- `ltx-2.3-22b-dev_embeddings_connectors.safetensors`
- `ltx-2.3-spatial-upscaler-x2-1.0.safetensors`
- `ltx-2.3-22b-distilled-lora-384.safetensors`
- `taeltx2_3.safetensors`
- `MelBandRoformer_fp16.safetensors`

## Folder Guidance

Use the current ComfyUI search conventions for your install, but keep these practical defaults in mind:

- UNet / GGUF model: the model path used by `UnetLoaderGGUF`
- Video VAE: the standard VAE folder
- Audio VAE: the VAE folder used by the KJ audio loader
- Gemma plus connector embeddings: the CLIP / text-encoder search path used by the dual CLIP loaders
- Spatial upscaler: the latent-upscale model folder
- LoRA: `loras`
- Tiny VAE preview: the VAE folder

The upstream custom-audio note mentions `models\\diffusion_models` near the MelBand RoFormer download link. Treat that as a source note, not a guaranteed universal path. Verify the expected folder against the installed `ComfyUI-MelBandRoFormer` node version.

## Notebook Launch Modes

The notebook supports four exposure patterns:

- default Colab native port forwarding
- `use_cloudflare`
- `use_ngrok`
- `use_interface_in_cell`

When `offload_models_for_low_VRAM` is true, the notebook launches ComfyUI with:

```bash
python main.py --cache-none --dont-print-server
```

Otherwise it uses:

```bash
python main.py --dont-print-server
```

## Runtime Expectations from the Notebook

The notebook markdown claims:

- Free T4 with default models and settings can do about 5 seconds of 480p text-to-video in around 20 minutes.
- The same setup can do about 3 seconds of 480x832 image-to-video in around 17 minutes.
- L4 can reach about 20 seconds of 720p in under 15 minutes.

Use these as rough expectations only. Do not present them as measured facts for another machine without a fresh run.

## First Smoke Run

1. Import the JSON into ComfyUI.
2. Confirm all nodes resolve.
3. Use a short prompt, a small image, and a short audio clip.
4. Keep the run at about 3-5 seconds and a moderate size.
5. Confirm the output MP4 is created before spending time on prompt tuning.
