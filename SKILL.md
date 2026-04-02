---
name: ltx23-comfyui-ti2v-audio
description: Use when you need to run, configure, explain, or adapt Isi-dev style LTX 2.3 ComfyUI workflows for text-to-video or image-to-video with audio, including remote GPU machine bootstrap, App JSON controls, prompt handling, lip-sync audio flow, and model or custom-node setup.
---

# LTX2.3 ComfyUI TI2V + Audio

Use this skill when the user wants to work from `sources/upstream/isi-dev/LTX_2.3_Image_or_Text_&_Audio_2_Video_App_V3.json` or `sources/upstream/isi-dev/ComfyUI_LTX2_3_TI2V.ipynb`, or when they want LTX 2.3 text/image plus audio to video in ComfyUI.

## Start Here

- Preserve the upstream artifacts under `sources/upstream/isi-dev/` as read-only references.
- Prefer the scripted bootstrap path first.
  - local setup launcher: [scripts/run-remote-gpu-setup.ps1](./scripts/run-remote-gpu-setup.ps1)
  - local start launcher: [scripts/run-remote-gpu-start.ps1](./scripts/run-remote-gpu-start.ps1)
  - remote installer: [scripts/setup-remote-ltx23-comfyui.sh](./scripts/setup-remote-ltx23-comfyui.sh)
  - remote starter: [scripts/start-remote-comfyui.sh](./scripts/start-remote-comfyui.sh)
  - detailed usage: [references/scripted-setup.md](./references/scripted-setup.md)
- Read [references/source-materials.md](./references/source-materials.md) if provenance or upstream comparison matters.
- Read [references/setup-and-models.md](./references/setup-and-models.md) before environment or model work.
- Read [references/usage-and-parameters.md](./references/usage-and-parameters.md) before changing prompts or generation settings.
- If you add Python helpers in this repo, run them with `uv run ...`.

## Choose the Source of Truth

- Use the App JSON when the task is "import this into ComfyUI" or "explain which controls the App exposes".
- Use the notebook when the task is "bootstrap the remote GPU machine / ComfyUI stack" or "recover the dependency list".
- When the task is actual environment setup on a remote Linux GPU host, prefer running the scripted bootstrap that was derived from the notebook instead of replaying notebook shell lines manually.
- When notebook notes and graph internals disagree, prefer the actual JSON graph for exposed controls and use the notes as soft operating guidance. Call out mismatches instead of flattening them.

## Scripted Setup Rules

1. Use [scripts/run-remote-gpu-setup.ps1](./scripts/run-remote-gpu-setup.ps1) from Windows when the operator has an SSH path to the remote GPU machine.
2. The setup launcher streams and runs [scripts/setup-remote-ltx23-comfyui.sh](./scripts/setup-remote-ltx23-comfyui.sh) on the remote side.
3. Start the service with [scripts/run-remote-gpu-start.ps1](./scripts/run-remote-gpu-start.ps1), which streams [scripts/start-remote-comfyui.sh](./scripts/start-remote-comfyui.sh).
4. Keep the notebook as the source of truth for dependency and model selection, but centralize operational fixes in the script.
5. Preserve the script guards for:
   - `LD_LIBRARY_PATH=/usr/lib64-nvidia`
   - `PIP_CONFIG_FILE=/dev/null`
   - writable install-directory resolution for `/content/ComfyUI` versus `~/ComfyUI`
6. If setup fails, inspect which step broke and patch the script rather than falling back to ad hoc command replay.

## Default Operating Model

1. Run the scripted setup path unless the user explicitly wants a manual notebook walkthrough.
2. Start ComfyUI after setup instead of assuming the installer leaves a service running.
3. Verify ComfyUI plus the required custom nodes are installed.
4. Verify the expected model files exist before blaming the graph.
5. Import `sources/upstream/isi-dev/LTX_2.3_Image_or_Text_&_Audio_2_Video_App_V3.json`.
6. Prepare prompt text, reference audio, and optionally a reference image.
7. Treat the packaged App V3 as audio-driven by default. Uploaded audio is on the active path, and `USE ONLY VOCALS` is App-exposed.
8. For text-to-video, flip `Text To Video (no image ref)` to `true`, but still keep an image available because the notebook explicitly warns that loading an image helps avoid errors.
9. Keep first smoke runs short, with moderate size and a fixed seed.
10. Validate the produced MP4, audio, lip-sync, and actual output size or duration before claiming the workflow is working.

## Prompt Rules

- Describe motion and sound chronologically.
- Do not restate details already fixed by the reference image unless the scene is intentionally changing.
- Do not invent camera motion unless the user asks for it.
- Do not invent dialogue unless the user asks for speaking, singing, or conversation.
- Keep the prompt as one concise English paragraph if you are targeting the built-in prompt-enhancer path.

## Parameter Rules

- Distinguish `extra.linearData` App inputs from graph-only defaults.
- The packaged App V3 exposes prompt, image, audio, audio start trim, width, height, length, text-to-video mode, `USE ONLY VOCALS`, seed, and an `Enhanced Prompt` surface. It does not expose App-side FPS control or the internal custom-audio versus LTX-audio latent switch.
- `length_seconds` is converted into frame count with `1 + 8 * round(seconds * fps / 8)`. Expect internal rounding.
- The custom-audio trim duration is derived from `frames / fps`, so audio segment length follows the generated clip length.
- Upstream notes warn that invalid size or frame settings can be silently nudged to nearby valid values. In practice, the current defaults and resizers point toward clean multiples of `32` for width and height. Recommend clean multiples of `32` and verify the actual output size after generation.
- `fps` exists in the graph with default `24`, but it is not one of the App inputs exposed by this JSON. Do not promise an App-side FPS control unless you are editing the graph.
- `USE ONLY VOCALS` is useful when the reference audio has busy accompaniment and lip-sync quality matters more than preserving the full mix.

## Audio Path Rules

- The graph loads audio once, trims a segment downstream, optionally separates vocals with MelBandRoFormer, then encodes audio latent.
- Preserve that pattern if you adapt the workflow. Do not duplicate audio loads per segment.
- The graph contains both custom-audio and LTX-audio latent paths, but the packaged App V3 does not expose the custom-audio switch. If a user asks for generated LTX audio instead of uploaded audio, say that workflow editing is required.
- If a user-made LoRA introduces noisy audio, the upstream note recommends the KJNodes advanced LTX-2 LoRA loader with non-video strength set to zero.

## Validation

1. Setup validation: confirm the setup script completed and `torch.cuda.is_available()` is true on the remote host.
2. Service validation: confirm ComfyUI started and the configured port is open.
3. Static validation: confirm the JSON imports and all custom nodes resolve.
4. Asset validation: confirm image, audio, and model files exist in the expected folders.
5. Smoke run: 3-5 seconds, modest resolution, fixed seed.
6. Output validation: inspect video, audio, lip-sync, and any silent parameter rounding.
7. Only call it "working" after at least one real generation run or after clearly labeling the result as unverified.

## Repository References

- Upstream workflow: `sources/upstream/isi-dev/LTX_2.3_Image_or_Text_&_Audio_2_Video_App_V3.json`
- Upstream notebook: `sources/upstream/isi-dev/ComfyUI_LTX2_3_TI2V.ipynb`
