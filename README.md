# LTX2.3 ComfyUI TI2V + Audio Skill

`Isi-dev` の LTX 2.3 ワークフローと Colab ノートを元に、ComfyUI で Text/Image + Audio to Video を扱うための Codex スキル用リポジトリです。

## 収録内容

- `Skill.md`: 依頼どおりのメイン文書
- `SKILL.md`: Codex スキル互換用のミラー
- `references/setup-and-models.md`: セットアップ、依存 custom nodes、モデル配置
- `references/usage-and-parameters.md`: App 入力、主要パラメータ、運用メモ
- `references/*.md`: 追加の詳細メモ。入力一覧、チューニング、runtime セットアップ、参照元整理を分割保存
- `sources/upstream/isi-dev/`: 参照元 JSON / Notebook の保管場所

## 参照元

- [ComfyUI_LTX2_3](https://github.com/Isi-dev/Google-Colab_Notebooks/tree/main/ComfyUI/ComfyUI_LTX2_3)
- [Google-Colab_Notebooks](https://github.com/Isi-dev/Google-Colab_Notebooks/tree/main)

## 使い方

1. `Skill.md` か `SKILL.md` を読ませる
2. `references/` の補助資料を必要に応じて読む
3. `sources/upstream/isi-dev/LTX_2.3_Image_or_Text_&_Audio_2_Video_App_V3.json` を ComfyUI に読み込む
4. `sources/upstream/isi-dev/ComfyUI_LTX2_3_TI2V.ipynb` を Colab セットアップの参照に使う

## 方針

- upstream の JSON / Notebook は `sources/upstream/isi-dev/` に退避し、編集せず参照専用として扱います。
- スキル本文は短く保ち、詳細な運用情報は `references/` に分離しています。
