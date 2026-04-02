# 2026-04-03 10s Q6 Resolution Check

## Question

Can `Q6_K` fit on the L4 at `10s`, and can the shorter duration still leave enough room for a higher resolution?

## Fixed inputs

- image: `momiji-studio_0008.png`
- audio: `midnight-memory-intro-chorus1.wav`
- prompt: fixed
- seed: `43`
- `USE ONLY VOCALS`: `true`

## Results

| Run | Duration | Resolution | Gen Time | Peak VRAM | Headroom | Recommended VRAM | Result |
| --- | --- | --- | --- | --- | --- | --- | --- |
| `check10-q6k-960x544` | `10s` | `960x544` | `395.691s` | `20148 MiB` | `2886 MiB` | `21 GiB` | success |
| `check10-q6k-1280x704` | `10s` | `1280x704` | `540.687s` | `21718 MiB` | `1316 MiB` | `22 GiB` | success |

## Comparison against Q5_K_M

| Model | Duration | Resolution | Peak VRAM | Gen Time |
| --- | --- | --- | --- | --- |
| `Q5_K_M` | `10s` | `960x544` | `18804 MiB` | `397.257s` |
| `Q6_K` | `10s` | `960x544` | `20148 MiB` | `395.691s` |
| `Q5_K_M` | `10s` | `1280x704` | `20628 MiB` | `541.488s` |
| `Q6_K` | `10s` | `1280x704` | `21718 MiB` | `540.687s` |

## Conclusion

Yes. `Q6_K` fit at `10s` on the L4, and the shorter duration also allowed a higher-resolution run at `1280x704`.

## Caution

- `Q6_K` at `1280x704` only left about `1316 MiB` of headroom, so it is a much tighter fit than the `Q5_K_M` version.
- This means the answer is "yes, but with less safety margin."
- If you go above `1280x704`, or increase duration again, expect the risk of failure to rise quickly.
