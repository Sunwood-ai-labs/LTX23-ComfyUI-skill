# Workflow Parameters

This file maps the exposed controls and important internal behavior from the archived app JSON.

## Main User-Facing Controls

| Control | Node title / type | Default | Meaning | Notes |
| --- | --- | --- | --- | --- |
| Prompt | `PROMPT` / `PrimitiveStringMultiline` | singing example prompt | Main scene prompt | Upstream enhancer expects one concise English paragraph |
| Width | `WIDTH` / `INTConstant` | `480` | Output width target | Shipped default is a multiple of 32 |
| Height | `HEIGHT` / `INTConstant` | `832` | Output height target | Shipped default is a multiple of 32 |
| Duration | `LENGTH (in seconds)` / `INTConstant` | `10` | Target duration | Workflow notes suggest `5`, `10`, or `20` |
| FPS | `FPS` / `PrimitiveFloat` | `24` | Frame rate | Workflow notes suggest `24` or `25` |
| Text mode | `Text To Video (no image ref)` / `PrimitiveBoolean` | `false` | Bypasses image injection nodes | Keep an uploaded image anyway because the notebook warns about errors otherwise |
| Prompt enhancer | `ENABLE PROMPT ENHANCER` / `Fast Groups Bypasser (rgthree)` | enabled group present | Optional prompt rewriting | Can be bypassed if unstable |
| Custom audio switch | `Custom Audio = true \|  LTX Audio  = false` / `ComfySwitchNode` | `true` | Chooses uploaded-audio latent vs LTX latent audio | `true` uses uploaded audio |
| Vocal isolation | `USE ONLY VOCALS` / `ComfySwitchNode` | `true` | Chooses MelBandRoFormer vocals vs full audio | Only relevant in custom-audio mode |
| Image input | `LoadImage` | sample image | Reference image | Input label explicitly says upload an image even for text mode |
| Audio input | `LoadAudio` | sample mp3 | Reference audio | Required when custom audio mode is enabled |

## Derived Values

### Frame count

Node `SimpleCalculatorKJ` uses:

`1 + 8 * (round(seconds * fps) / 8)`

The result is sent into `Set_frames`.

Example:

- `10` seconds at `24` fps becomes `241` frames.

### Trimmed audio duration

Another `SimpleCalculatorKJ` uses:

`frames / fps`

That result feeds `TrimAudioDuration`, so the custom audio path is trimmed to the actual generated clip length.

## Mode Behavior

### Image + custom audio

- `Text To Video (no image ref) = false`
- `Custom Audio = true | LTX Audio = false = true`
- `USE ONLY VOCALS` may stay `true` for cleaner lip-sync

### Text + custom audio

- Set text mode to `true`
- Keep an uploaded image present anyway
- Keep custom audio switch at `true`

### Image + LTX audio

- Keep text mode `false`
- Set custom audio switch to `false`

### Text + LTX audio

- Set text mode `true`
- Set custom audio switch to `false`
- Keep an uploaded image present anyway

## Prompt Guidance Extracted From The Workflow

The archived prompt-instruct node pushes these rules:

- Describe actions over time.
- Describe sounds and dialogue as part of the same flow.
- Do not repeat image details that the reference image already provides.
- Use active present-progressive verbs.
- Avoid inventing camera motion unless requested.
- Include exact quoted dialogue only when speech is needed.
- Keep output to one concise paragraph in natural English.

## Advanced Tuning Seen In The Workflow

- LTX scheduler node:
  - steps-like setting set to `8`
  - additional values `2.05`, `0.95`, `True`, `0.1`
- Sampler selectors seen:
  - `euler_cfg_pp`
  - `euler_ancestral_cfg_pp`
- Manual sigma presets are present for alternate schedules.
- Distilled LoRA default strength is `0.6`.

## Important Caveat About Geometry

The workflow note says width and height must be divisible by `32 + 1`, but the shipped defaults are `480 x 832`, which are clean multiples of `32`. Treat the note as inconsistent. Prefer the shipped defaults or other multiples of `32`, then verify the real output size.
