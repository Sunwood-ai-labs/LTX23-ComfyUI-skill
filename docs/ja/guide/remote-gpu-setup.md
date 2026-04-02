# Remote GPU セットアップ

## 概要

このリポジトリでは、notebook を手で再生する代わりに、remote GPU machine 向けの script で環境をそろえることを標準運用にしています。

## launcher / script

- Windows setup launcher: [run-remote-gpu-setup.ps1](https://github.com/Sunwood-ai-labs/LTX23-ComfyUI-skill/blob/main/scripts/run-remote-gpu-setup.ps1)
- Windows start launcher: [run-remote-gpu-start.ps1](https://github.com/Sunwood-ai-labs/LTX23-ComfyUI-skill/blob/main/scripts/run-remote-gpu-start.ps1)
- remote setup script: [setup-remote-ltx23-comfyui.sh](https://github.com/Sunwood-ai-labs/LTX23-ComfyUI-skill/blob/main/scripts/setup-remote-ltx23-comfyui.sh)
- remote start script: [start-remote-comfyui.sh](https://github.com/Sunwood-ai-labs/LTX23-ComfyUI-skill/blob/main/scripts/start-remote-comfyui.sh)

## 基本手順

1. Windows から setup launcher を実行する
2. remote installer が ComfyUI / custom nodes / model assets をそろえる
3. start launcher で ComfyUI を起動する
4. API 応答を確認してから workflow を読み込む

## コマンド

```powershell
.\scripts\run-remote-gpu-setup.ps1
.\scripts\run-remote-gpu-start.ps1 -Restart
```

## 便利なオプション

```powershell
.\scripts\run-remote-gpu-setup.ps1 -SkipModels
.\scripts\run-remote-gpu-setup.ps1 -IncludeManager
.\scripts\run-remote-gpu-start.ps1 -NoLowVram
```

## script が吸収する問題

- NVIDIA library path 不足
- global pip config 崩れ
- stale な install directory
- low-VRAM 向け起動引数

## 失敗時チェック

- GPU が見えない:
  - `LD_LIBRARY_PATH=/usr/lib64-nvidia` を確認
  - `torch.cuda.is_available()` または `/system_stats` を確認
- `pip` が permission で落ちる:
  - `PIP_CONFIG_FILE=/dev/null` を確認
- `/content/ComfyUI` の clone が失敗する:
  - stale directory や root-owned remnant を疑う
- notebook の shell を手で打って挙動がずれる:
  - launcher script を優先して CRLF と stale dir 対策を踏ませる
