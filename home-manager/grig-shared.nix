{
  pkgs,
  lib,
  inputs,
  ...
}:
with lib; {
  colorScheme = inputs.nix-colors.colorSchemes.catppuccin-mocha;

  imports = [
    inputs.nix-colors.homeManagerModules.default

    ./configs/my.nix
    ./configs/nix.nix
    ./configs/lf
    ./configs/fzf.nix
    ./configs/bat.nix
    ./configs/git.nix
    ./configs/gitui.nix
    ./configs/fish.nix
    ./configs/tmux.nix
    ./configs/neovim.nix
    ./configs/syncthing.nix
  ];

  xdg.enable = true;

  home = {
    packages = with pkgs; [
      htop
      wget
      curl
      unzip
      tldr
      exa
      zip
      tree
    ];

    sessionVariables = {
      CONFIG = mkDefault "$HOME/.config";
    };

    sessionPath = [
      "$HOME/.local/bin"
    ];

    shellAliases = {
      # Verbosity and settings that you pretty much just always are going to want.
      cp = "cp -ivr";
      mv = "mv -iv";
      rm = "rm -vI";
      #      mkdir = "mkdir -pv";

      # Colorize commands when possible.
      ls = "exa --icons";
      grep = "grep --color=auto";
      diff = "diff --color=auto";
      ccat = "highlight --out-format=ansi";
      ip = "ip -color=auto";

      # shortcuts
      e = "$EDITOR";
    };
  };
}
