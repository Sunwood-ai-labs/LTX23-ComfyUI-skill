param(
    [string]$Hostname = "skill-samples-letting-tasks.trycloudflare.com",
    [string]$User = "maki",
    [string]$KeyPath = "$HOME\.ssh\google_colab_jupyter_ssh_key",
    [string]$RemoteInstallDir = "/content/ComfyUI",
    [int]$Port = 8188,
    [switch]$Restart,
    [switch]$NoLowVram
)

$scriptPath = Join-Path $PSScriptRoot "start-remote-comfyui.sh"
if (-not (Test-Path $scriptPath)) {
    throw "Missing start script: $scriptPath"
}
$remoteScript = "/tmp/start-remote-comfyui.sh"

$remoteArgs = @("--install-dir", $RemoteInstallDir, "--port", $Port)
if ($Restart) { $remoteArgs += "--restart" }
if ($NoLowVram) { $remoteArgs += "--no-low-vram" }
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
