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
    ./imports/git.nix
    ./imports/fish.nix
  ];

  home.packages = with pkgs; [
    htop
    git
    wget
    curl
    unzip
    tldr
    vifm
    chezmoi
    age
    exa
    ripgrep

    # nvim
    gcc

    # dev
    dotnet-sdk_6
    msbuild
    # nodejs_20
  ];

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
