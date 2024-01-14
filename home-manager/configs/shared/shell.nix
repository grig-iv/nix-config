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

    ./../../modules

    ./../nix.nix
    ./../lf.nix
    ./../skim.nix
    ./../bat.nix
    ./../git.nix
    ./../eza.nix
    ./../gitui.nix
    ./../fish.nix
    ./../tmux.nix
    ./../neovim.nix
    ./../development/fennel.nix
  ];

  xdg.enable = true;

  my.shell.bookmarks.h = "~/";

  home = rec {
    # FIXME
    username = lib.mkDefault "grig";
    homeDirectory = lib.mkDefault "/home/${username}";

    packages = with pkgs; [
      htop
      wget
      curl
      unzip
      tldr
      zip
      tree
      babashka
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
      #ls = "exa --icons";
      grep = "grep --color=auto";
      diff = "diff --color=auto";
      ccat = "highlight --out-format=ansi";
      ip = "ip -color=auto";

      # shortcuts
      e = "$EDITOR";
    };
  };
}
