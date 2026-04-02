# 2026-04-02 20s First Minute

## Fixed inputs

- image: `momiji-studio_0008.png`
- audio: `midnight-memory-intro-chorus1.wav`
- prompt: fixed across all runs
- duration per run: `20s`
- total covered audio range: `0s` to `60s`
- local outputs: `outputs/2026-04-02-20s-first-minute-http`

## Batch rule

- prompt fixed
- image fixed
- audio fixed
- only the model and 20-second segment offset changed

## Per-run results

| Run | Model | Segment | Output | Gen Time | Peak VRAM | Headroom | Size |
| --- | --- | --- | --- | --- | --- | --- | --- |
| `seg01-q5km-s00-20` | `Q5_K_M` | `0-20` | `seg01-q5km-s00-20_00001-audio.mp4` | `565.023s` | `20884 MiB` | `2150 MiB` | `4019964` |
| `seg02-q5km-s20-40` | `Q5_K_M` | `20-40` | `seg02-q5km-s20-40_00001-audio.mp4` | `566.645s` | `20884 MiB` | `2150 MiB` | `3896106` |
| `seg03-q5km-s40-60` | `Q5_K_M` | `40-60` | `seg03-q5km-s40-60_00001-audio.mp4` | `568.893s` | `20884 MiB` | `2150 MiB` | `4286672` |
| `seg04-q4km-s00-20` | `Q4_K_M` | `0-20` | `seg04-q4km-s00-20_00001-audio.mp4` | `556.539s` | `19220 MiB` | `3814 MiB` | `3822918` |
| `seg05-q4km-s20-40` | `Q4_K_M` | `20-40` | `seg05-q4km-s20-40_00001-audio.mp4` | `556.510s` | `19220 MiB` | `3814 MiB` | `3889219` |
| `seg06-q4km-s40-60` | `Q4_K_M` | `40-60` | `seg06-q4km-s40-60_00001-audio.mp4` | `556.802s` | `19220 MiB` | `3814 MiB` | `3958852` |
| `seg07-q4_1-s00-20` | `Q4_1` | `0-20` | `seg07-q4_1-s00-20_00001-audio.mp4` | `554.482s` | `18676 MiB` | `4358 MiB` | `4331579` |
| `seg08-q4_1-s20-40` | `Q4_1` | `20-40` | `seg08-q4_1-s20-40_00001-audio.mp4` | `555.416s` | `18676 MiB` | `4358 MiB` | `4642396` |
| `seg09-q4_1-s40-60` | `Q4_1` | `40-60` | `seg09-q4_1-s40-60_00001-audio.mp4` | `555.436s` | `18676 MiB` | `4358 MiB` | `4698221` |

## Model summary

| Model | Runs | Avg Gen Time | Peak VRAM | Estimated Minimum | Recommended VRAM | L4 Headroom |
| --- | --- | --- | --- | --- | --- | --- |
| `Q5_K_M` | `3` | `566.854s` | `20884 MiB` | `21 GiB` | `22 GiB` | `2150 MiB` |
| `Q4_K_M` | `3` | `556.617s` | `19220 MiB` | `19 GiB` | `20 GiB` | `3814 MiB` |
| `Q4_1` | `3` | `555.111s` | `18676 MiB` | `19 GiB` | `20 GiB` | `4358 MiB` |

## Interpretation

- `Q4_1` was the lightest model in this batch and left the most VRAM headroom.
- `Q5_K_M` fit on the L4, but only left about `2.1 GiB` of headroom, so it is the tightest option here.
- Generation time stayed close across models, but `Q5_K_M` was consistently the slowest.
- For this `20s`, `960x544`, fixed-input setup:
  - treat `Q4_1` and `Q4_K_M` as `20 GiB` class workloads
  - treat `Q5_K_M` as a `22 GiB` class workload
