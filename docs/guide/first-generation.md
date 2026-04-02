# First Generation

## Recommended first run

Start with a short verification render before attempting a long audio-driven clip.

Suggested baseline:

- image mode enabled
- short clean reference audio
- `960x544` or `480x832`
- `5` seconds
- fixed seed

## Workflow import

Use the archived App workflow:

- [LTX_2.3_Image_or_Text_&_Audio_2_Video_App_V3.json](https://github.com/Sunwood-ai-labs/LTX23-ComfyUI-skill/blob/main/sources/upstream/isi-dev/LTX_2.3_Image_or_Text_%26_Audio_2_Video_App_V3.json)

Keep the notebook as a dependency reference:

- [ComfyUI_LTX2_3_TI2V.ipynb](https://github.com/Sunwood-ai-labs/LTX23-ComfyUI-skill/blob/main/sources/upstream/isi-dev/ComfyUI_LTX2_3_TI2V.ipynb)

## Input checklist

- prompt text is set
- reference image is loaded
- reference audio is loaded
- the model files listed in the setup guide exist on the remote GPU machine
- `USE ONLY VOCALS` is chosen intentionally

## What to validate

- the MP4 is created
- lip-sync and facial framing are plausible
- duration and aspect ratio match expectations closely enough
- the remote GPU machine stays stable under the chosen settings

## Comparison rule

If the batch is about model comparison:

- keep prompt fixed
- keep image fixed
- keep audio fixed
- keep duration fixed
- change only one or two variables at a time

If you already have [the committed API prompt](https://github.com/Sunwood-ai-labs/LTX23-ComfyUI-skill/blob/main/sources/api/ltx23-ti2v-audio-api-prompt.json), use that for direct `/prompt` execution instead of repeating UI export.

## Output Retrieval Rule

- After pulling outputs back from the remote machine, compare the local file size with the recorded remote size before treating the file as valid.
