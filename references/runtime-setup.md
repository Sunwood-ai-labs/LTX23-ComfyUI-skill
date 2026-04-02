# Runtime Setup

## Upstream artifacts

- Notebook: [../sources/upstream/isi-dev/ComfyUI_LTX2_3_TI2V.ipynb](../sources/upstream/isi-dev/ComfyUI_LTX2_3_TI2V.ipynb)
- Workflow: [../sources/upstream/isi-dev/LTX_2.3_Image_or_Text_&_Audio_2_Video_App_V3.json](../sources/upstream/isi-dev/LTX_2.3_Image_or_Text_&_Audio_2_Video_App_V3.json)

## Notebook defaults

The Colab notebook exposes these booleans near the top:

- `offload_models_for_low_VRAM = True`
- `include_manager = False`
- `include_ltxNodes = True`
- `include_rgthree = True`
- `include_Easy_Use = True`
- `include_VideoHelperSuite = True`
- `include_MelBandRoFormer = True`

If you are recreating the environment locally, treat everything except `ComfyUI-Manager` as required for the provided App V3 workflow.

## Custom nodes cloned by the notebook

- `https://github.com/kijai/ComfyUI-KJNodes`
- `https://github.com/city96/ComfyUI-GGUF`
- `https://github.com/Lightricks/ComfyUI-LTXVideo/`
- `https://github.com/rgthree/rgthree-comfy.git`
- `https://github.com/yolain/ComfyUI-Easy-Use`
- `https://github.com/Kosinkadink/ComfyUI-VideoHelperSuite`
- `https://github.com/kijai/ComfyUI-MelBandRoFormer`
- optional: `https://github.com/Comfy-Org/ComfyUI-Manager`

## Models downloaded in the notebook

| File | Target directory | Source family |
| --- | --- | --- |
| `ltx-2.3-22b-dev-Q4_K_M.gguf` | `models/unet` | `unsloth/LTX-2.3-GGUF` |
| `gemma_3_12B_it_fp8_scaled.safetensors` | `models/text_encoders` | `Comfy-Org/ltx-2` |
| `mmproj-BF16.gguf` | `models/text_encoders` | `unsloth/gemma-3-12b-it-qat-GGUF` |
| `ltx-2.3-22b-dev_embeddings_connectors.safetensors` | `models/text_encoders` | `unsloth/LTX-2.3-GGUF` |
| `ltx-2.3-22b-dev_video_vae.safetensors` | `models/vae` | `unsloth/LTX-2.3-GGUF` |
| `ltx-2.3-22b-dev_audio_vae.safetensors` | `models/vae` | `unsloth/LTX-2.3-GGUF` |
| `ltx-2.3-spatial-upscaler-x2-1.0.safetensors` | `models/latent_upscale_models` | `Lightricks/LTX-2.3` |
| `taeltx2_3.safetensors` | `models/vae` | `Kijai/LTX2.3_comfy` |
| `MelBandRoformer_fp16.safetensors` | `models/diffusion_models` | `Kijai/MelBandRoFormer_comfy` |
| `ltx-2.3-22b-distilled-lora-384.safetensors` | `models/loras` | `Lightricks/LTX-2.3` |

## Loader defaults seen in the workflow

- UNet loader default: `ltx-2.3-22b-dev-Q4_K_M.gguf`
- Video VAE loader default: `ltx-2.3-22b-dev_video_vae.safetensors`
- Audio VAE loader default: `ltx-2.3-22b-dev_audio_vae.safetensors`
- Text encoder pair: `gemma_3_12B_it_fp8_scaled.safetensors` + `ltx-2.3-22b-dev_embeddings_connectors.safetensors`
- Tiny preview VAE: `taeltx2_3.safetensors`
- MelBandRoFormer loader default: `MelBandRoformer_fp16.safetensors`
- Distill LoRA default strength: `0.6`

## Launch modes used by the notebook

The notebook supports four exposure patterns:

- `use_ngrok = False`
- `use_cloudflare = False`
- `use_interface_in_cell = False`
- default Colab window link mode

When `offload_models_for_low_VRAM` is true, the notebook launches ComfyUI with:

```bash
python main.py --cache-none --dont-print-server
```

Otherwise it uses:

```bash
python main.py --dont-print-server
```

Use the low-VRAM form when reproducing the notebook on constrained hardware.

## Practical reconstruction order

1. Install ComfyUI.
2. Add the custom nodes above.
3. Place the model files into the matching `models/` folders.
4. Start ComfyUI.
5. Import the App V3 workflow.
6. Run a short smoke test before any high-resolution render.
