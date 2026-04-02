# 2026-04-03 10s 1080p Quantization Check

## Question

Which lower-quantized models can complete a `10s` run at `1920x1088` on the L4 when prompt, image, and audio stay fixed?

## Fixed inputs

- image: `momiji-studio_0008.png`
- audio: `midnight-memory-intro-chorus1.wav`
- prompt: fixed
- duration: `10s`
- resolution: `1920x1088`
- seed: `43`
- `USE ONLY VOCALS`: `true`

## Results

| Run | Model | Gen Time | Peak VRAM | Headroom | Recommended VRAM | Result |
| --- | --- | --- | --- | --- | --- | --- |
| `check10-q4_1-1920x1088` | `Q4_1` | `1153.463s` | `18420 MiB` | `4614 MiB` | `20 GiB` | success |
| `check10-q3km-1920x1088` | `Q3_K_M` | `1102.948s` | `18420 MiB` | `4614 MiB` | `20 GiB` | success |
| `check10-q2k-1920x1088` | `Q2_K` | `1083.705s` | `17652 MiB` | `5382 MiB` | `19 GiB` | success |

## Conclusion

Yes. With the fixed inputs and `10s` duration, all three lower-quantized models tested here completed successfully at `1920x1088` on the L4.

## Ranking

- Most headroom: `Q2_K`
- Middle: `Q4_1` and `Q3_K_M` were effectively tied on peak VRAM in this batch
- Fastest: `Q2_K`
- Slowest: `Q4_1`

## Practical recommendation

- If your main goal is "make 1080p fit on the L4 with margin", start with `Q2_K`.
- If you want a less aggressively quantized model while still fitting, `Q4_1` also worked at `1920x1088`.
- `Q3_K_M` did fit, but it did not beat `Q4_1` on VRAM in this particular batch.

## Caveat

- This batch shows feasibility for these exact fixed inputs.
- It does not guarantee that every image, audio segment, or prompt variant at `1920x1088` will have the same VRAM behavior.
