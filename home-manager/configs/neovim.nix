{
  pkgs,
  lib,
  ...
}:
with lib; {
  imports = [./development/lua.nix];

  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
      withNodeJs = true;
      withPython3 = true;
      extraPackages = with pkgs; [
        gcc
      ];
    };
    ripgrep.enable = true;
  };

  home = {
    packages = with pkgs; [
      git
      wget
      curl
      unzip
      tree-sitter
      fd
      jq
      nodejs_20
      nodePackages.cspell
    ];

    shellAliases = {
      n = "jump -r $HOME/.config/nvim";
    };
  };
}
