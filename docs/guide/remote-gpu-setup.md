# Remote GPU Setup

## Overview

This repository prefers a script-first workflow for preparing a remote GPU machine instead of replaying notebook cells by hand.

## Launchers

- Windows setup launcher: [run-remote-gpu-setup.ps1](https://github.com/Sunwood-ai-labs/LTX23-ComfyUI-skill/blob/main/scripts/run-remote-gpu-setup.ps1)
- Windows start launcher: [run-remote-gpu-start.ps1](https://github.com/Sunwood-ai-labs/LTX23-ComfyUI-skill/blob/main/scripts/run-remote-gpu-start.ps1)
- Remote setup script: [setup-remote-ltx23-comfyui.sh](https://github.com/Sunwood-ai-labs/LTX23-ComfyUI-skill/blob/main/scripts/setup-remote-ltx23-comfyui.sh)
- Remote start script: [start-remote-comfyui.sh](https://github.com/Sunwood-ai-labs/LTX23-ComfyUI-skill/blob/main/scripts/start-remote-comfyui.sh)

## Basic flow

1. Run the setup launcher from Windows.
2. Wait for the remote installer to finish cloning ComfyUI, custom nodes, and model assets.
3. Start ComfyUI on the remote GPU machine.
4. Confirm the API responds before importing the workflow or running a generation.

## Commands

```powershell
.\scripts\run-remote-gpu-setup.ps1
.\scripts\run-remote-gpu-start.ps1 -Restart
```

## Useful flags

```powershell
.\scripts\run-remote-gpu-setup.ps1 -SkipModels
.\scripts\run-remote-gpu-setup.ps1 -IncludeManager
.\scripts\run-remote-gpu-start.ps1 -NoLowVram
```

## Operational fixes already built in

- `LD_LIBRARY_PATH=/usr/lib64-nvidia`
- `PIP_CONFIG_FILE=/dev/null`
- stale install-directory backup before clone
- low-VRAM launch path with `--cache-none`
