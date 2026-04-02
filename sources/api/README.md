# API Prompt Source

This folder stores API-ready prompt data derived from the archived ComfyUI workflow.

## Included file

- [ltx23-ti2v-audio-api-prompt.json](./ltx23-ti2v-audio-api-prompt.json)

## Purpose

Use this API-format prompt as the base payload for `/prompt` calls when you want to avoid converting the UI workflow again.

## Rule

- Treat the archived workflow under `sources/upstream/isi-dev/` as the upstream source.
- Treat the file in this folder as the committed API execution form.
- When the upstream workflow changes materially, regenerate and recommit the API prompt file.
