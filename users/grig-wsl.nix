{
  config,
  pkgs,
  lib,
  inputs,
  ...
} @ args: {
  imports = [
    inputs.nix-colors.homeManagerModules.default

    ./modules/my.nix
    ./modules/lf
    ./modules/fish.nix
    ./modules/tmux.nix
    ./modules/neovim.nix
    ./modules/git.nix
    ./modules/dotnet.nix
  ];

  home.packages = with pkgs; [
    htop
    git
    wget
    curl
    unzip
    tldr
    exa
    wslu
    zip
    chezmoi
    age

    # nvim
    alejandra
    tree-sitter
    gcc
    ripgrep
    fd
    stylua
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
