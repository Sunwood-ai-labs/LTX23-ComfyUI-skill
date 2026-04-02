param(
    [string]$Hostname = "skill-samples-letting-tasks.trycloudflare.com",
    [string]$User = "maki",
    [string]$KeyPath = "$HOME\.ssh\google_colab_jupyter_ssh_key",
    [string]$RemoteInstallDir = "/content/ComfyUI",
    [switch]$IncludeManager,
    [switch]$SkipModels,
    [switch]$SkipLora
)

$scriptPath = Join-Path $PSScriptRoot "setup-remote-ltx23-comfyui.sh"
if (-not (Test-Path $scriptPath)) {
    throw "Missing setup script: $scriptPath"
}
$remoteScript = "/tmp/setup-remote-ltx23-comfyui.sh"

$remoteArgs = @("--install-dir", $RemoteInstallDir)
if ($IncludeManager) { $remoteArgs += "--include-manager" }
if ($SkipModels) { $remoteArgs += "--skip-models" }
if ($SkipLora) { $remoteArgs += "--skip-lora" }
$sshArgs = @(
    "-o", "StrictHostKeyChecking=accept-new",
    "-o", "ProxyCommand=cloudflared access ssh --hostname $Hostname",
    "-i", $KeyPath
)

& scp @sshArgs $scriptPath "${User}@${Hostname}:$remoteScript"
if ($LASTEXITCODE -ne 0) {
    exit $LASTEXITCODE
}

$normalize = "python3 -c `"from pathlib import Path; p = Path(r'$remoteScript'); p.write_bytes(p.read_bytes().replace(b'\r\n', b'\n').replace(b'\r', b'\n'))`""
& ssh @sshArgs "$User@$Hostname" "$normalize && bash $remoteScript $($remoteArgs -join ' ')"
exit $LASTEXITCODE
