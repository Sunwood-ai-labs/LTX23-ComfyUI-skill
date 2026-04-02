---
layout: home

hero:
  name: "LTX2.3 ComfyUI Skill Repo"
  text: "LTX 2.3 TI2V + audio の remote GPU 運用"
  tagline: "Isi-dev の archived workflow を remote GPU machine 上で扱うための scripts・references・公開ドキュメントをまとめています。"
  image:
    src: /logo.svg
    alt: LTX2.3 ComfyUI Skill Repo
  actions:
    - theme: brand
      text: Remote GPU セットアップ
      link: /ja/guide/remote-gpu-setup
    - theme: alt
      text: Workflow リファレンス
      link: /ja/guide/workflow-reference
    - theme: alt
      text: GitHub
      link: https://github.com/Sunwood-ai-labs/LTX23-ComfyUI-skill

features:
  - title: Script First
    details: notebook の shell を都度貼り直すのではなく、remote GPU machine 向け script でセットアップと起動を進めます。
  - title: 実機検証済み
    details: NVIDIA L4 上で ComfyUI 起動と generation check まで実行した運用前提の repo です。
  - title: Workflow 整理
    details: archived App workflow と notebook は source artifact として保持し、実務に必要な読み方を references に分離しています。
  - title: 英日併記
    details: 公開 README と docs を英日で並行化し、operator 向けの参照性を高めています。
---
