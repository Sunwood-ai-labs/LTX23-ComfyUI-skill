---
name: ltx23-comfyui-ti2v-audio
description: Use when you need to run, configure, or adapt Isi-dev's LTX 2.3 ComfyUI workflow for text-to-video or image-to-video with audio, including custom-node setup, required models, App-exposed inputs, prompt rules, and audio lip-sync flow.
---

# LTX2.3 ComfyUI TI2V + Audio

Use this skill when the user wants to work from `LTX_2.3_Image_or_Text_&_Audio_2_Video_App_V3.json` or `ComfyUI_LTX2_3_TI2V.ipynb`, or when they want LTX 2.3 text/image plus audio to video in ComfyUI.

## Start Here

- Preserve the upstream artifacts under `sources/upstream/isi-dev/` as read-only references.
- Read [references/setup-and-models.md](./references/setup-and-models.md) before environment or model work.
- Read [references/usage-and-parameters.md](./references/usage-and-parameters.md) before changing prompts or generation settings.
- If you add Python helpers in this repo, run them with `uv run ...`.

## Choose the Source of Truth

- Use the App JSON when the task is "import this into ComfyUI" or "explain which controls the App exposes".
- Use the notebook when the task is "bootstrap Colab / ComfyUI" or "recover the dependency list".
- When notebook notes and graph internals disagree, prefer the actual JSON graph for exposed controls and use the notes as soft operating guidance. Call out mismatches instead of flattening them.

## Baseline Workflow

1. Verify ComfyUI plus the required custom nodes are installed.
2. Verify the expected model files exist before blaming the graph.
3. Import `sources/upstream/isi-dev/LTX_2.3_Image_or_Text_&_Audio_2_Video_App_V3.json`.
4. Prepare three user assets: prompt text, reference image, and reference audio.
5. Default mode is image-to-video with audio. For text-to-video, flip `Text To Video (no image ref)` to `true`, but still keep an image loaded because the notebook explicitly warns that pure T2V without an image can error in this package.
6. Keep first smoke runs short: about 3-5 seconds at 480x832 or 832x480 before scaling up.
7. Treat audio as part of the scene description. If the audio is dialog, keep spoken words in quotes only when the user actually wants speech.
8. Validate the produced MP4, lip-sync, and prompt adherence before claiming the workflow is working.

## Prompting Rules

- Describe motion and sound chronologically.
- Do not restate details already fixed by the reference image unless the scene is intentionally changing.
- Do not invent camera motion unless the user asks for it.
- Do not invent dialogue unless the user asks for speaking, singing, or conversation.
- Keep the prompt as one concise English paragraph if you are targeting the built-in prompt-enhancer path.

## Parameter Rules

- Distinguish App-exposed inputs from graph-only defaults. The App JSON exposes a smaller control set than the full graph.
- `length_seconds` is converted into frame count inside the graph with `1 + 8 * round(seconds * fps / 8)`. Expect internal rounding.
- Upstream note text warns that invalid size or frame settings are silently nudged to nearby valid values. In practice, the graph defaults and resizers point toward multiples of 32 for width and height. Recommend clean multiples of 32 and confirm the actual output size after generation.
- `fps` exists in the graph with default `24`, but it is not one of the linear App inputs exposed by this JSON. Do not promise an App-side FPS control unless you are editing the graph.
- `USE ONLY VOCALS` is useful when the reference audio has busy accompaniment and lip-sync quality matters more than preserving the full mix.

## Audio Path

- The graph loads audio once, trims a segment downstream, optionally separates vocals with MelBandRoFormer, and only then encodes audio latent.
- Preserve that pattern if you adapt the workflow. Do not duplicate audio loads per segment.
- If a user-made LoRA introduces noisy audio, the upstream note recommends the KJNodes advanced LTX-2 LoRA loader with non-video strength set to zero.

## Validation

1. Static validation: confirm the JSON imports and all custom nodes resolve.
2. Asset validation: confirm image, audio, and model files exist in the expected folders.
3. Smoke run: 3-5 seconds, modest resolution, fixed seed.
4. Output validation: inspect video, audio, lip-sync, and any silent parameter rounding.
5. Only call it "working" after at least one real generation run or after clearly labeling the result as unverified.

## Repository References

- Upstream workflow: `sources/upstream/isi-dev/LTX_2.3_Image_or_Text_&_Audio_2_Video_App_V3.json`
- Upstream notebook: `sources/upstream/isi-dev/ComfyUI_LTX2_3_TI2V.ipynb`
