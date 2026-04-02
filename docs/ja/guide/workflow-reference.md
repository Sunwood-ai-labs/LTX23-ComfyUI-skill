# Workflow リファレンス

## source artifact

- [Workflow JSON](https://github.com/Sunwood-ai-labs/LTX23-ComfyUI-skill/blob/main/sources/upstream/isi-dev/LTX_2.3_Image_or_Text_%26_Audio_2_Video_App_V3.json)
- [Notebook](https://github.com/Sunwood-ai-labs/LTX23-ComfyUI-skill/blob/main/sources/upstream/isi-dev/ComfyUI_LTX2_3_TI2V.ipynb)

## 主な exposed inputs

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

## 内部で起きること

- fps は graph 内部の値
- frame count は seconds と fps から導出される
- audio duration は生成 clip 長に追従する
- 不正な geometry は近い値に寄ることがある

## 詳細参照

- [remote GPU セットアップ](/ja/guide/remote-gpu-setup)
- [workflow and parameters](https://github.com/Sunwood-ai-labs/LTX23-ComfyUI-skill/blob/main/references/usage-and-parameters.md)
- [scripted setup](https://github.com/Sunwood-ai-labs/LTX23-ComfyUI-skill/blob/main/references/scripted-setup.md)
