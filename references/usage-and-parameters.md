# Usage and Parameters

## App-Exposed Inputs in the JSON

The JSON's `extra.linearData.inputs` exposes these App-facing controls:

| Control | Node | Default | Notes |
| --- | --- | --- | --- |
| `Text To Video (no image ref)` | `PrimitiveBoolean` 290 | `false` | Switches the workflow toward T2V, but the notebook still recommends loading an image to avoid errors. |
| `PROMPT` | `PrimitiveStringMultiline` 352 | sample prompt | Raw user prompt. Can be passed through the prompt-enhancer path. |
| `image` | `LoadImage` 167 | sample PNG | Reference frame for image-to-video and still recommended as a fallback asset in T2V mode. |
| `WIDTH` | `INTConstant` 292 | `480` | The App default is portrait. |
| `HEIGHT` | `INTConstant` 293 | `832` | Together with width, this makes the packaged App default `480x832`. |
| `LENGTH (in seconds)` | `INTConstant` 291 | `10` | Converted into frame count inside the graph. |
| `audio` | `LoadAudio` 372 | sample MP3 | Source audio for lip-sync / audio-conditioned generation. |
| `start_index` | `TrimAudioDuration` 373 | `1` | Audio trim start point. |
| `USE ONLY VOCALS` | `ComfySwitchNode` 382 | `true` | When true, the vocal-isolated output is fed into audio encoding. |
| `noise_seed` | `RandomNoise` 115 | `43` | Fixed sample seed in the packaged workflow. |

## Important Graph Defaults That Are Not App Inputs

These defaults exist in the graph even though they are not exposed through `linearData`:

- `FPS`: `24`
- `LTXVConditioning` frame-rate input default: `24`
- First-pass sampler choice: `euler_ancestral_cfg_pp`
- Second-pass sampler choice: `euler_cfg_pp`
- `LTXVScheduler (for more steps)`: `[8, 2.05, 0.95, true, 0.1]`
- `LTX2_NAG`: `[11, 0.25, 2.5, true]`
- Image preprocess node: `LTXVPreprocess` with `33`

If the user needs these changed from the App side, the workflow itself must be edited.

## Prompt Flow

The packaged graph contains both:

- a raw `PROMPT` input node
- a `TextGenerateLTX2Prompt` enhancer path that takes `clip + image + prompt`

That means prompt handling is layered:

1. user raw prompt
2. optional enhancer step
3. final conditioning through `CLIPTextEncode`

When explaining or adapting the workflow, keep those layers distinct.

## Prompting Tips from the Embedded Notes

- Describe actions as they happen over time.
- Describe sounds and dialogue as part of the scene, not as an afterthought.
- Do not repeat details already fixed by the reference image.
- Avoid instructions that fight the image; consistency matters.
- Keep camera motion explicit. If the user did not ask for camera movement, do not add it.

## Size, FPS, and Duration Guidance

The embedded notes recommend:

- Low VRAM: try `832x480` or `960x544`
- Stronger GPUs: try `1280x720` or higher
- Duration: `5`, `10`, or `20` seconds
- FPS: `24` or `25`, optionally `48` or `50` on stronger hardware

The shipped App JSON currently defaults to `480x832`, so do not assume the note's landscape recommendation matches the packaged default orientation.

## Hidden Rounding and Validity Caveats

Two different hints appear in the upstream material:

- Embedded note text says invalid width, height, or frame settings are silently adjusted to nearby valid values.
- The graph itself clearly derives frame count with `1 + 8 * round(seconds * fps / 8)`.

For width and height, the note text is more ambiguous than the graph. The practical guidance is:

- prefer clean multiples of `32`
- expect silent adjustment if the value is not ideal
- verify the actual generated output instead of trusting the requested size blindly

## Audio Path

The audio branch is:

1. `LoadAudio`
2. `TrimAudioDuration`
3. optional `MelBandRoFormerSampler`
4. `USE ONLY VOCALS` switch
5. `LTXVAudioVAEEncode`

This is useful when explaining custom-audio lip-sync:

- if the audio is already clean, the raw trimmed audio may be enough
- if the mix is busy, isolating vocals can improve lip-sync focus

## LoRA Caveat

One embedded note warns that some user-made LTX-2 LoRAs are not trained on audio and can introduce noisy output audio. If that happens, prefer the advanced KJNodes LoRA loader path and set non-video strength to zero.
