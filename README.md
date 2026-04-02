# LTX2.3 ComfyUI Skill Repo

This repository packages Isi-dev's `LTX2.3 for Text & Image to Video+Audio with ComfyUI` as a reusable local Codex skill repo. The upstream notebook and App JSON are preserved as source artifacts, while setup notes and parameter guidance live in `SKILL.md` and `references/`.

## About `Skill.md`

This workspace is on Windows, so `Skill.md` and `SKILL.md` resolve to the same file. The canonical file in this repo is [SKILL.md](./SKILL.md), and it satisfies the requested `./Skill.md` path in this environment.

## Contents

- [SKILL.md](./SKILL.md)
  - Main skill instructions
- [scripts/run-colab-setup.ps1](./scripts/run-colab-setup.ps1)
  - Windows launcher that streams the remote setup script over SSH
- [scripts/run-colab-start.ps1](./scripts/run-colab-start.ps1)
  - Windows launcher that starts ComfyUI on the remote host
- [scripts/setup-remote-ltx23-comfyui.sh](./scripts/setup-remote-ltx23-comfyui.sh)
  - Remote Linux bootstrap script derived from the upstream notebook
- [scripts/start-remote-comfyui.sh](./scripts/start-remote-comfyui.sh)
  - Remote Linux start script for ComfyUI
- [references/scripted-setup.md](./references/scripted-setup.md)
  - Script-first setup flow and options
- [references/source-materials.md](./references/source-materials.md)
  - Upstream URLs, local archive paths, and source roles
- [references/setup-and-models.md](./references/setup-and-models.md)
  - Colab and ComfyUI setup, custom nodes, and required models
- [references/usage-and-parameters.md](./references/usage-and-parameters.md)
  - App inputs, internal parameters, audio path, and prompting notes
- [sources/upstream/isi-dev/](./sources/upstream/isi-dev/)
  - Archived notebook and App JSON
- [agents/openai.yaml](./agents/openai.yaml)
  - Minimal UI metadata for the skill

## Usage

1. Open [SKILL.md](./SKILL.md).
2. For remote setup, run [scripts/run-colab-setup.ps1](./scripts/run-colab-setup.ps1).
3. Start ComfyUI with [scripts/run-colab-start.ps1](./scripts/run-colab-start.ps1).
4. Read [references/scripted-setup.md](./references/scripted-setup.md) for the script-first bootstrap flow.
5. Read [references/source-materials.md](./references/source-materials.md) when provenance matters.
6. Read [references/setup-and-models.md](./references/setup-and-models.md) for environment and model setup.
7. Read [references/usage-and-parameters.md](./references/usage-and-parameters.md) for workflow behavior and tuning.
8. If you want to edit the upstream workflow, copy it out of `sources/upstream/isi-dev/` first.

## Upstream References

- [Isi-dev / Google-Colab_Notebooks](https://github.com/Isi-dev/Google-Colab_Notebooks/tree/main)
- [Isi-dev / ComfyUI_LTX2_3](https://github.com/Isi-dev/Google-Colab_Notebooks/tree/main/ComfyUI/ComfyUI_LTX2_3)
- [Lightricks / LTX-2](https://github.com/Lightricks/LTX-2)
- [Lightricks / ComfyUI-LTXVideo](https://github.com/Lightricks/ComfyUI-LTXVideo/)

## Repo Rules

- Keep the upstream JSON and notebook under `sources/upstream/isi-dev/`.
- Prefer the script-driven bootstrap before replaying notebook commands by hand.
- Keep the main skill concise and move detail into `references/`.
- Use `uv run ...` for Python-based helper checks.
