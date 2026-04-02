# 2026-04-02 15s Fixed Inputs

## Fixed inputs

- image: `momiji-studio_0008.png`
- audio: `midnight-memory-intro-chorus1.wav`
- duration: `15s`
- prompt: fixed across all runs

## Varied parameters

- `ltx_model`
- `USE ONLY VOCALS`

## Runs

| Run | Model | Vocals | Output | Peak VRAM | Headroom | Size |
| --- | --- | --- | --- | --- | --- | --- |
| `exp01-q4km-960x544-vocals-on` | `Q4_K_M` | `true` | `exp01-q4km-960x544-vocals-on_00001-audio.mp4` | `18354 MiB` | `4680 MiB` | `3003282` |
| `exp02-q4_1-960x544-vocals-on` | `Q4_1` | `true` | `exp02-q4_1-960x544-vocals-on_00001-audio.mp4` | `17842 MiB` | `5192 MiB` | `3335054` |
| `exp03-q5km-960x544-vocals-on` | `Q5_K_M` | `true` | `exp03-q5km-960x544-vocals-on_00001-audio.mp4` | `20018 MiB` | `3016 MiB` | `3310816` |
| `exp04-q4km-960x544-vocals-off` | `Q4_K_M` | `false` | `exp04-q4km-960x544-vocals-off_00001-audio.mp4` | `18354 MiB` | `4680 MiB` | `2968458` |

## Observations

- `Q4_1` used less VRAM than the `Q4_K_M` baseline and left the most headroom in this batch.
- `Q5_K_M` consumed the most VRAM and left the smallest headroom on the L4.
- Turning `USE ONLY VOCALS` off did not materially reduce VRAM usage relative to the `Q4_K_M` baseline, but it did change the output file size slightly.
- All four runs completed successfully at `15.042s`.

## Notes

- This batch intentionally fixed prompt, image, audio, duration, and seed.
- Future batches should preserve the same manifest schema so runs remain comparable.
