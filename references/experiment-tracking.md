# Experiment Tracking

Use this repository to keep a lightweight record of real remote GPU runs.

## What to record

For every experiment batch, keep these items together:

- fixed inputs
  - prompt text
  - image filename
  - audio filename
  - duration
- varied parameters
  - model file
  - resolution
  - seed
  - switches such as `USE ONLY VOCALS`
- execution result
  - `prompt_id`
  - output filename
  - remote output path
  - duration
  - file size
- GPU telemetry
  - total VRAM
  - peak used VRAM
  - estimated minimum VRAM
  - recommended VRAM target
  - estimated headroom
  - peak utilization

## Recommended layout

Store each batch under `experiments/<date>-<slug>/`:

```text
experiments/
└─ 2026-04-02-15s-fixed-inputs/
   ├─ manifest.json
   └─ summary.md
```

## Why this matters

- it prevents losing which output belongs to which parameter set
- it makes GPU headroom visible before a longer sweep
- it gives future API-only automation a stable schema to append to

## Notes

- Keep generated videos out of git unless there is a strong reason to publish them.
- Commit the metadata and summary, not the heavy media files.
- If prompt, image, or audio are fixed for a batch, write that once at the top-level batch metadata rather than repeating it in every run.
- After local download, compare the local file size with the recorded remote size so partial transfers do not silently pass.

## Batch comparison rules

- If the goal is model comparison, keep prompt, image, audio, and duration fixed.
- If the goal is timeline coverage, record `segment_start_seconds` and `segment_end_target_seconds`.
- If you copy outputs back locally, compare local file sizes with the remote originals before trusting the set.
