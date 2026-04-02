# Tuning and Caveats

## Prompting guidance from the workflow notes

The workflow's `Prompting LTX-2` note says to structure prompts around:

1. Core actions over time.
2. Audio, dialogue, and sound cues.
3. Reference-image-aware prompting without repeating obvious visual facts.
4. Consistency with the image, because conflicting instructions degrade results.

## Video-setting guidance from the workflow notes

- Low RAM / VRAM suggestion: `832 x 480` or `960 x 544`
- Preferred target when possible: `1280 x 720` or higher
- Suggested durations: `5`, `10`, or `20` seconds
- Suggested FPS: `24` or `25`, with `48` / `50` only when hardware can handle it

Note that the App V3 defaults are portrait `480 x 832`, so the workflow clearly supports both portrait and landscape-oriented setups.

## Size and frame caveat

The `About Size` note says width and height must align to a 32-based size rule and frame count must align to an 8-based rule. The same note also says invalid values do not raise an error and are silently nudged to a nearby valid value.

Treat that as a warning about implicit coercion:

- do not assume requested dimensions are exactly what gets sampled
- do not assume requested seconds map exactly to final frame count
- verify the output metadata when duration or framing precision matters

## Custom audio guidance

The `Custom Audio` note recommends:

- use reference audio when you want lip-sync to follow the provided audio
- prompt explicitly that the subject is talking or singing
- include a transcript or speech summary when possible
- use MelBandRoFormer when you want cleaner vocals from busy source audio

## Prompt enhancer caveat

The `Prompt Enhancer (Optional)` note says the enhancer can be sensitive when the GGUF-side Gemma setup is not correct. If prompts look unstable or obviously unrelated to the raw input:

- bypass the enhancer
- author the raw prompt directly
- confirm the text encoder assets before debugging the sampler

## LoRA caveat

The `User Made Loras` note warns that some community LoRAs are not trained for audio and can create noisy audio outputs. If that happens:

- reduce or remove the LoRA
- prefer the KJNodes advanced LTX-2 LoRA handling path
- set non-video strength to zero when the LoRA should not color the audio branch

## Good smoke-test presets

Use one of these before any long run:

- `480 x 832`, `24 fps`, `3-5 sec`, short speech or singing clip
- `832 x 480`, `24 fps`, `5 sec`, simple motion and clean vocals
- `960 x 544`, `24 fps`, `5-8 sec`, only after the first lower-cost run succeeds
