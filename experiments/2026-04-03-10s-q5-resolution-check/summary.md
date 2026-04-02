# 2026-04-03 10s Q5 Resolution Check

## Question

Does reducing duration from `20s` to `10s` reduce VRAM enough to keep the higher-precision `Q5_K_M` model and raise resolution?

## Fixed inputs

- model family: `Q5_K_M`
- image: `momiji-studio_0008.png`
- audio: `midnight-memory-intro-chorus1.wav`
- prompt: fixed
- seed: `43`
- `USE ONLY VOCALS`: `true`

## Results

| Run | Duration | Resolution | Gen Time | Peak VRAM | Headroom | Recommended VRAM | Result |
| --- | --- | --- | --- | --- | --- | --- | --- |
| `check10-q5km-960x544` | `10s` | `960x544` | `397.257s` | `18804 MiB` | `4230 MiB` | `20 GiB` | success |
| `check10-q5km-1280x704` | `10s` | `1280x704` | `541.488s` | `20628 MiB` | `2406 MiB` | `22 GiB` | success |

## Comparison against the earlier 20s baseline

Reference:

- `20s`
- `960x544`
- `Q5_K_M`
- peak VRAM `20884 MiB`

Observed deltas:

- dropping from `20s` to `10s` at `960x544` reduced peak VRAM from `20884 MiB` to `18804 MiB`
- that freed about `2080 MiB`
- with `10s`, raising resolution to `1280x704` still fit on the L4 and stayed slightly below the old `20s` baseline peak

## Conclusion

Yes. In this workflow and machine setup, cutting the duration to `10s` reduced VRAM enough that `Q5_K_M` could be run at a higher resolution (`1280x704`) and still complete successfully.

## Caution

- This does not prove that every heavier model will fit.
- It specifically shows that the current `Q5_K_M` model benefits from the shorter duration enough to make a higher resolution practical on the L4.
- If you want to test `Q6_K` or above, run that as a new batch instead of assuming it will fit from this result alone.
