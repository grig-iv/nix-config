#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "Please run this script as root (using sudo)."
  exit 1
fi

echo "Downloading disko.nix to /tmp/disko.nix..."
curl -L -o /tmp/disko.nix https://raw.githubusercontent.com/grig-iv/nix-config/refs/heads/main/nixos/xtal/disko.nix

echo "Running nix with flakes and disko..."
nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko /tmp/disko.nix

echo "Removing all files from /mnt/etc/nixos..."
rm -rf /mnt/etc/nixos/*

echo "Opening nix-shell and cloning a GitHub repository..."
nix-shell -p git --run "git clone https://github.com/grig-iv/nix-config.git /mnt/etc/nixos"

echo "Starting nixos installation"
nixos-install --flake /mnt/etc/nixos#xtal

echo "Script execution complete!"
