---
layout: home

hero:
  name: "LTX2.3 ComfyUI Skill Repo"
  text: "Remote GPU workflows for LTX 2.3 TI2V + audio"
  tagline: "Scripts, references, and public docs for running Isi-dev's archived LTX 2.3 ComfyUI workflow on a remote GPU machine."
  image:
    src: /logo.svg
    alt: LTX2.3 ComfyUI Skill Repo
  actions:
    - theme: brand
      text: Remote GPU Setup
      link: /guide/remote-gpu-setup
    - theme: alt
      text: Workflow Reference
      link: /guide/workflow-reference
    - theme: alt
      text: GitHub
      link: https://github.com/Sunwood-ai-labs/LTX23-ComfyUI-skill

features:
  - title: Scripted Setup
    details: Reproduce the upstream notebook on a remote GPU machine with PowerShell launchers and Linux setup scripts.
  - title: Verified Runtime
    details: The repository has been exercised against a real NVIDIA L4 machine, including ComfyUI startup and generation checks.
  - title: Workflow Reference
    details: Keep the archived App workflow and notebook as source artifacts while documenting the actual exposed controls and runtime expectations.
  - title: Bilingual Docs
    details: English and Japanese docs stay parallel so operators can move quickly between public guidance and local execution.
---
