# LTX2.3 ComfyUI TI2V + Audio Skill

`Isi-dev` の LTX 2.3 系 ComfyUI 資料をもとに、Text/Image + Audio to Video を扱うための Codex スキル用リポジトリです。依頼どおり `Skill.md` を置きつつ、Codex 互換用の `SKILL.md` も同内容で揃えています。

## 収録内容

- `Skill.md`
  - 依頼どおりのメイン文書
- `SKILL.md`
  - Codex スキル互換用ミラー
- `references/source-materials.md`
  - 参照元 URL、ローカル保存物、由来の整理
- `references/setup-and-models.md`
  - Colab / ComfyUI セットアップ、custom nodes、モデル配置
- `references/usage-and-parameters.md`
  - App 入力、内部パラメータ、音声経路、運用上の注意
- `sources/upstream/isi-dev/`
  - 元の Notebook / App JSON を退避した参照専用領域

## 参照元

- [ComfyUI_LTX2_3](https://github.com/Isi-dev/Google-Colab_Notebooks/tree/main/ComfyUI/ComfyUI_LTX2_3)
- [Google-Colab_Notebooks](https://github.com/Isi-dev/Google-Colab_Notebooks/tree/main)

## 使い方

1. Codex に `Skill.md` か `SKILL.md` を読ませる
2. 必要に応じて `references/` を追加で読む
3. `sources/upstream/isi-dev/LTX_2.3_Image_or_Text_&_Audio_2_Video_App_V3.json` を ComfyUI に読み込む
4. `sources/upstream/isi-dev/ComfyUI_LTX2_3_TI2V.ipynb` を Colab セットアップや依存確認の参照に使う

## リポジトリ構成

```text
.
|- Skill.md
|- SKILL.md
|- README.md
|- agents/
|  `- openai.yaml
|- references/
|  |- source-materials.md
|  |- setup-and-models.md
|  `- usage-and-parameters.md
`- sources/upstream/isi-dev/
   |- ComfyUI_LTX2_3_TI2V.ipynb
   `- LTX_2.3_Image_or_Text_&_Audio_2_Video_App_V3.json
```

## 方針

- upstream の JSON / Notebook は `sources/upstream/isi-dev/` に固定し、編集せず参照専用として扱います。
- スキル本文は短く保ち、詳細は `references/` に分離します。
- このリポジトリでは Python を使う補助作業を `uv run ...` 前提で扱います。
