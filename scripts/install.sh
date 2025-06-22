#!/usr/bin/env sh

# sudo apt update
# sudo apt install curl
# 

sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon
sh -c 'nix run home-manager/master -- switch --flake github:grig-iv/nix-config#$(whoami)@$(hostname)'
sh -c 'git clone git@github.com:grig-iv/nix-config.git ~/.config/nix-config'
