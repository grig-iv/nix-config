$ErrorActionPreference = 'Stop'

# Ensure the script is running with administrative privileges
if (-NOT ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Error "Please run this script as an Administrator."
    exit
}

# Install WSL if it's not already installed
if (-not (Get-WindowsOptionalFeature -Online -FeatureName Microsoft-Windows-Subsystem-Linux).State -eq 'Enabled') {
    Write-Host "Installing WSL..."
    DISM.exe /Online /Enable-Feature /FeatureName:Microsoft-Windows-Subsystem-Linux /All /NoRestart
}

# Enable Virtual Machine Platform if not already enabled
if (-not (Get-WindowsOptionalFeature -Online -FeatureName VirtualMachinePlatform).State -eq 'Enabled') {
    Write-Host "Enabling Virtual Machine Platform..."
    DISM.exe /Online /Enable-Feature /FeatureName:VirtualMachinePlatform /All /NoRestart
}

# Set WSL default version to 2
wsl --set-default-version 2
wsl --update

# Download the latest nixos-wsl.tar.gz from GitHub releases
$downloadUrl = "https://github.com/nix-community/NixOS-WSL/releases/latest/download/nixos-wsl.tar.gz"
$downloadPath = "$HOME\Downloads\nixos-wsl.tar.gz"

try {
    Write-Host "Downloading NixOS-WSL to $downloadPath..."
    Invoke-WebRequest -Uri $downloadUrl -OutFile $downloadPath -ErrorAction Stop
    Write-Host "Download completed successfully."
} catch {
    Write-Error "Failed to download NixOS-WSL: $_"
    exit
}

# Import the downloaded tarball into WSL
Write-Host "Importing NixOS-WSL into WSL..."
wsl --import NixOS .\NixOS\ $downloadPath --version 2
wsl --set-default NixOS

# Start NixOS-WSL and run the command
Write-Host "Starting NixOS-WSL and updating nix-channel..."
wsl --shell-type login -- sudo nix-channel --update
wsl
