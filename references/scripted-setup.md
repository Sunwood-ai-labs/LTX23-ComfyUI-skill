# Scripted Setup

Use the scripts in this repository instead of replaying the notebook manually whenever you have SSH access to a remote GPU machine.

## Files

- Local setup launcher: [../scripts/run-remote-gpu-setup.ps1](../scripts/run-remote-gpu-setup.ps1)
- Local start launcher: [../scripts/run-remote-gpu-start.ps1](../scripts/run-remote-gpu-start.ps1)
- Remote installer: [../scripts/setup-remote-ltx23-comfyui.sh](../scripts/setup-remote-ltx23-comfyui.sh)
- Remote starter: [../scripts/start-remote-comfyui.sh](../scripts/start-remote-comfyui.sh)

## What the scripts do

The remote installer reproduces the notebook's setup intent and adds guards for the SSH-hosted remote GPU machine case:

- exports `LD_LIBRARY_PATH=/usr/lib64-nvidia` so the remote shell can see the GPU driver libraries
- neutralizes broken host-wide pip logging with `PIP_CONFIG_FILE=/dev/null`
- creates or fixes access to the target install directory
- installs `aria2`
- installs the notebook's Python dependencies
- clones ComfyUI and the required custom nodes
- installs custom-node requirements
- downloads the notebook's core models and the default distilled LoRA

See [operational-lessons.md](./operational-lessons.md) for the broader recurrence notes from real setup and generation runs.

## Default invocation

From Windows PowerShell:

```powershell
.\scripts\run-remote-gpu-setup.ps1 `
  -Hostname skill-samples-letting-tasks.trycloudflare.com `
  -User maki `
  -RemoteInstallDir /content/ComfyUI
```

Then start ComfyUI:

```powershell
.\scripts\run-remote-gpu-start.ps1 `
  -Hostname skill-samples-letting-tasks.trycloudflare.com `
  -User maki `
  -RemoteInstallDir /content/ComfyUI `
  -Restart
```

## Useful switches

- `-SkipModels`
  - useful when the environment already has the model files
- `-SkipLora`
  - skips the default distilled LoRA download
- `-DryRun`
  - streams the installer and prints intended actions without executing them
- `-IncludeManager`
  - also installs `ComfyUI-Manager`
- `-NoLowVram`
  - starts ComfyUI without `--cache-none`
- `-Restart`
  - stops existing `main.py` processes before starting ComfyUI

## Notes on install location

- The launcher defaults to `/content/ComfyUI` because that matches the notebook.
- If the SSH user cannot write `/content`, the remote installer uses `sudo` to create and hand over the directory.
- If `sudo` is unavailable and `/content` is not writable, pass a writable home-directory path with `-RemoteInstallDir`.

## Failure checklist

- GPU not visible:
  - confirm `LD_LIBRARY_PATH=/usr/lib64-nvidia`
  - confirm `torch.cuda.is_available()` and `/system_stats`
- pip fails with logging or permissions:
  - confirm `PIP_CONFIG_FILE=/dev/null`
- clone fails under `/content/ComfyUI`:
  - check for stale directories or root-owned remnants
- launcher succeeds but remote shell behaves strangely:
  - prefer the launcher scripts over hand-pasted notebook shell so line endings are normalized before bash executes

## When to fall back to manual notebook replay

Use the raw notebook only when:

- a specific dependency step is failing and you need to compare line-by-line behavior
- the upstream notebook changes and the scripts have not been updated yet
- you are debugging a new host type that does not match the current remote-GPU-over-SSH assumptions
