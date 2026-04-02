<p align="center">
  <img src="./docs/public/hero.svg" alt="LTX2.3 ComfyUI Skill Repo hero" width="100%" />
</p>

<div align="center">

# LTX2.3 ComfyUI Skill Repo

Isi-dev の LTX 2.3 Text / Image + Audio to Video 構成を、remote GPU machine 前提で再利用しやすくまとめた Codex skill repository です。

<p>
  <a href="https://github.com/Sunwood-ai-labs/LTX23-ComfyUI-skill/actions/workflows/docs.yml"><img alt="Docs" src="https://img.shields.io/github/actions/workflow/status/Sunwood-ai-labs/LTX23-ComfyUI-skill/docs.yml?branch=main&label=docs&style=flat-square"></a>
  <a href="./LICENSE"><img alt="MIT License" src="https://img.shields.io/badge/license-MIT-1f4d3a?style=flat-square"></a>
  <img alt="Remote GPU" src="https://img.shields.io/badge/runtime-remote%20GPU-c56a2d?style=flat-square">
  <img alt="VitePress" src="https://img.shields.io/badge/docs-VitePress-bc7a28?style=flat-square">
</p>

<p>
  <a href="./README.md"><strong>English</strong></a> ·
  <a href="./README.ja.md"><strong>日本語</strong></a> ·
  <a href="https://sunwood-ai-labs.github.io/LTX23-ComfyUI-skill/"><strong>Docs Site</strong></a>
</p>

</div>

## ✨ 概要

このリポジトリは、upstream の notebook と App workflow をそのまま保管しつつ、実運用で必要な内容を次の形に整理しています。

- remote GPU machine への ComfyUI セットアップ自動化
- low-VRAM を意識した ComfyUI 起動フロー
- LTX 2.3 workflow のパラメータ整理
- 実素材を使った generation 検証のための運用導線

upstream 資料は [sources/upstream/isi-dev](./sources/upstream/isi-dev/) に保存し、運用ガイドは [SKILL.md](./SKILL.md)、[references](./references/)、[scripts](./scripts/) に分離しています。

## 🚀 クイックスタート

1. Windows から [run-remote-gpu-setup.ps1](./scripts/run-remote-gpu-setup.ps1) を実行して、remote GPU machine に ComfyUI / custom nodes / LTX 2.3 モデルを入れる
2. [run-remote-gpu-start.ps1](./scripts/run-remote-gpu-start.ps1) で ComfyUI を起動する
3. [LTX_2.3_Image_or_Text_&_Audio_2_Video_App_V3.json](./sources/upstream/isi-dev/LTX_2.3_Image_or_Text_&_Audio_2_Video_App_V3.json) を読み込む
4. prompt / image / audio を設定し、まず短い smoke run から始める

script-first のセットアップ手順は [references/scripted-setup.md](./references/scripted-setup.md) にまとめています。

## 🛰️ Remote GPU 運用

- セットアップ launcher:
  [run-remote-gpu-setup.ps1](./scripts/run-remote-gpu-setup.ps1)
- 起動 launcher:
  [run-remote-gpu-start.ps1](./scripts/run-remote-gpu-start.ps1)
- remote installer:
  [setup-remote-ltx23-comfyui.sh](./scripts/setup-remote-ltx23-comfyui.sh)
- remote starter:
  [start-remote-comfyui.sh](./scripts/start-remote-comfyui.sh)

現在の自動化は、remote GPU machine で起きやすい次の問題も吸収します。

- NVIDIA の user-space library が見えず GPU 検出に失敗する
- shared machine の global `pip` 設定が壊れている
- `/content/ComfyUI` に中途半端な stale ディレクトリが残る

## 📚 ドキュメント

- [Docs site](https://sunwood-ai-labs.github.io/LTX23-ComfyUI-skill/)
- [scripted setup guide](./references/scripted-setup.md)
- [setup and models reference](./references/setup-and-models.md)
- [workflow and parameters reference](./references/usage-and-parameters.md)
- [source materials and provenance](./references/source-materials.md)
- [English README](./README.md)

## 🧩 リポジトリ構成

```text
.
├─ SKILL.md
├─ README.md
├─ README.ja.md
├─ docs/
├─ references/
├─ scripts/
├─ sources/upstream/isi-dev/
└─ .github/workflows/
```

## 🔎 収録物

- [SKILL.md](./SKILL.md): Codex 用の主スキル本文
- [agents/openai.yaml](./agents/openai.yaml): skill UI メタデータ
- [docs](./docs/): 英日対応の公開ドキュメント
- [references](./references/): 実運用向けの補助資料
- [scripts](./scripts/): remote GPU machine 用セットアップ / 起動自動化

## 🪪 ライセンス

このリポジトリは [MIT License](./LICENSE) で公開しています。

## 🙏 参照元

- [Isi-dev / Google-Colab_Notebooks](https://github.com/Isi-dev/Google-Colab_Notebooks/tree/main)
- [Isi-dev / ComfyUI_LTX2_3](https://github.com/Isi-dev/Google-Colab_Notebooks/tree/main/ComfyUI/ComfyUI_LTX2_3)
- [Lightricks / LTX-2](https://github.com/Lightricks/LTX-2)
- [Lightricks / ComfyUI-LTXVideo](https://github.com/Lightricks/ComfyUI-LTXVideo/)
