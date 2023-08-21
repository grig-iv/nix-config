{
  config,
  pkgs,
  lib,
  inputs,
  ...
} @ args: {
  imports = [
    inputs.nix-colors.homeManagerModules.default

    ./modules
    ./imports/lf
    ./imports/git.nix
    ./imports/fish.nix
    ./imports/tmux.nix
  ];

  home.packages = with pkgs; [
    htop
    git
    wget
    curl
    unzip
    tldr
    chezmoi
    age
    exa
    ripgrep
    wslu
    chafa
    zip

    # nvim
    gcc
  ];

  my.hostInfo.isInWsl = true;

  home.activation = {
    appendFishExec = config.lib.dag.entryBefore ["writeBoundary"] ''
      #!/usr/bin/env bash
      if ! grep -q "exec fish" "$HOME/.profile"; then
        echo -e "\nexec fish" >> "$HOME/.profile"
      fi
    '';
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  home.sessionVariables = {
    NIXCONF = "${config.xdg.configHome}/nix-config";
  };

  colorScheme = inputs.nix-colors.colorSchemes.dracula;
}
