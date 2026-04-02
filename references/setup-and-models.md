# Setup and Models

## Preserved Upstream Artifacts

- `sources/upstream/isi-dev/LTX_2.3_Image_or_Text_&_Audio_2_Video_App_V3.json`
- `sources/upstream/isi-dev/ComfyUI_LTX2_3_TI2V.ipynb`

Treat these as immutable references. If you need to modify the workflow, work on a copy and keep the upstream originals intact.

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

If the workflow imports with missing nodes, check these first.

## Model Files Visible in the Workflow JSON

The graph references these filenames directly:

- `ltx-2.3-22b-dev-Q4_K_M.gguf`
- `ltx-2.3-22b-dev_video_vae.safetensors`
- `ltx-2.3-22b-dev_audio_vae.safetensors`
- `gemma_3_12B_it_fp8_scaled.safetensors`
- `ltx-2.3-22b-dev_embeddings_connectors.safetensors`
- `ltx-2.3-spatial-upscaler-x2-1.0.safetensors`
- `ltx-2.3-22b-distilled-lora-384.safetensors` (optional)
- `taeltx2_3.safetensors` (tiny VAE preview, optional but useful)
- `MelBandRoformer_fp16.safetensors` (optional for vocal isolation)

## Folder Guidance

Use the current ComfyUI/custom-node search conventions for your install, but keep these practical defaults in mind:

- UNet / GGUF model: the ComfyUI model loader search path used by `UnetLoaderGGUF`
- Video VAE: standard VAE model folder
- Audio VAE: the VAE folder used by the KJ loader node
- Gemma + connector embeddings: the CLIP / text-encoder search path used by the dual CLIP loaders
- Spatial upscaler: latent-upscale model folder
- LoRA: `loras`
- Tiny VAE preview: standard VAE folder

The upstream custom-audio note mentions `models\\diffusion_models` near the MelBand RoFormer download link. Treat that as a source note, not a guaranteed universal path. Verify the expected folder against the currently installed `ComfyUI-MelBandRoFormer` node version.

## Runtime Expectations from the Notebook

The notebook markdown claims:

- Free T4 with default models/settings can do about 5 seconds of 480p text-to-video in around 20 minutes.
- The same setup can do about 3 seconds of 480x832 image-to-video in around 17 minutes.
- L4 can reach about 20 seconds of 720p in under 15 minutes.

Use these as rough expectations only. Do not present them as measured facts for another machine without a fresh run.

## First Smoke Run

1. Import the JSON into ComfyUI.
2. Confirm all nodes resolve.
3. Use a short prompt, a small image, and a short audio clip.
4. Keep the run at about 3-5 seconds and a moderate size.
5. Confirm the output MP4 is created before spending time on prompt tuning.
