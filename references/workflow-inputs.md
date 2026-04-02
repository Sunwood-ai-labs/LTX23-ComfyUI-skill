# Workflow Inputs

## App V3 exposed inputs

The workflow's `extra.linearData.inputs` exposes these user-facing controls:

| App input | Node / field | Default | Notes |
| --- | --- | --- | --- |
| `Text To Video (no image ref)` | `PrimitiveBoolean` / `value` | `False` | Enables text-only mode. The notebook still warns that loading an image can help avoid errors. |
| `PROMPT` | `PrimitiveStringMultiline` / `value` | cinematic singing prompt | Main raw prompt field. |
| `Enhanced Prompt` | `easy showAnything` / `text` | refusal-style sample text | Treat as intermediate/debug text from the enhancer path, not the canonical authoring field. |
| `LoadImage` | `LoadImage` / `image` | sample PNG | First-frame or reference image. |
| `WIDTH` | `INTConstant` / `value` | `480` | Portrait-oriented default. |
| `HEIGHT` | `INTConstant` / `value` | `832` | Portrait-oriented default. |
| `LoadAudio` | `LoadAudio` / `audio` and `audioUI` | sample MP3 | Source audio for lip-sync / custom audio path. |
| `Audio trim start` | `TrimAudioDuration` / `start_index` | `1` | Only the start index is exposed in App V3. |
| `USE ONLY VOCALS` | `ComfySwitchNode` / `switch` | `True` | Favors vocal-only extraction when MelBandRoFormer is present. |
| `LENGTH (in seconds)` | `INTConstant` / `value` | `10` | Duration target used with FPS to derive frames. |
| `noise_seed` | `RandomNoise` / `noise_seed` | `43` | Random seed, with noise mode set to `fixed`. |

## Important internal defaults

- FPS is internally set to `24`.
- A calculator node derives frames with the expression `1 + 8 * (round(a * b) / 8)`.
- The output node is `VHS_VideoCombine` with H.264 MP4 output, `yuv420p`, `crf = 19`, and metadata saving enabled.
- The workflow contains a `Custom Audio = true | LTX Audio = false` switch that defaults to `True`.
- The prompt enhancer lane exists behind `ENABLE PROMPT ENHANCER`, but that toggle is not one of the App V3 exposed inputs.

## Runtime-sensitive caveats

- `TrimAudioDuration` shows widget values `[1, 8]`, but App V3 only exposes `start_index`. If audio/video duration mismatches matter, inspect this node directly in the graph.
- The workflow includes both `DualCLIPLoader` and `DualCLIPLoaderGGUF` paths, so mismatched text-encoder assets can break prompt enhancement before they break the core video path.
- The workflow uses nodes from KJNodes, GGUF, rgthree, Easy Use, VideoHelperSuite, LTXVideo, and MelBandRoFormer. Missing any of those packages can prevent graph load.

## Notable model and sampler defaults

- `UnetLoaderGGUF`: `ltx-2.3-22b-dev-Q4_K_M.gguf`
- `VAELoader` video: `ltx-2.3-22b-dev_video_vae.safetensors`
- `VAELoaderKJ` audio: `ltx-2.3-22b-dev_audio_vae.safetensors`
- `DualCLIPLoader`: `gemma_3_12B_it_fp8_scaled.safetensors` + `ltx-2.3-22b-dev_embeddings_connectors.safetensors`
- `LTXVScheduler`: `[8, 2.05, 0.95, True, 0.1]`
- Distill LoRA loader: `ltx-2.3-22b-distilled-lora-384.safetensors` at strength `0.6`

## Output

The App V3 output is the `VHS_VideoCombine` node. The captured sample metadata shows:

- `frame_rate = 24`
- `format = video/h264-mp4`
- `filename_prefix = LTX-2`
- `save_metadata = True`
- `save_output = True`
