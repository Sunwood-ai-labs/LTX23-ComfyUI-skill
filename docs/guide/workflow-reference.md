# Workflow Reference

## Source artifacts

- [Workflow JSON](https://github.com/Sunwood-ai-labs/LTX23-ComfyUI-skill/blob/main/sources/upstream/isi-dev/LTX_2.3_Image_or_Text_%26_Audio_2_Video_App_V3.json)
- [Notebook](https://github.com/Sunwood-ai-labs/LTX23-ComfyUI-skill/blob/main/sources/upstream/isi-dev/ComfyUI_LTX2_3_TI2V.ipynb)

## Main exposed inputs

- prompt
- image
- audio
- audio trim start
- width
- height
- length in seconds
- text-to-video mode
- `USE ONLY VOCALS`
- seed

## Important hidden behavior

- fps remains internal to the graph
- frame count is derived from seconds and fps
- audio duration follows generated clip length
- some invalid geometry values may be silently nudged

## Where to read more

- [remote GPU setup guide](/guide/remote-gpu-setup)
- [workflow and parameters](https://github.com/Sunwood-ai-labs/LTX23-ComfyUI-skill/blob/main/references/usage-and-parameters.md)
- [scripted setup](https://github.com/Sunwood-ai-labs/LTX23-ComfyUI-skill/blob/main/references/scripted-setup.md)
