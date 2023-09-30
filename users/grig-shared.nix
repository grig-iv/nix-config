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

    ./modules/my.nix
    ./modules/nix.nix
    ./modules/lf
    ./modules/git.nix
    ./modules/gitui.nix
    ./modules/fish.nix
    ./modules/tmux.nix
    ./modules/neovim.nix
    ./modules/lua.nix
    ./modules/syncthing.nix
  ];

  home.packages = with pkgs; [
    htop
    wget
    curl
    unzip
    tldr
    exa
    zip

    neofetch
    cbonsai
  ];

  home.sessionVariables = {
    CONFIG = mkDefault "$HOME/.config";
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];

  home.shellAliases = {
    # Verbosity and settings that you pretty much just always are going to want.
    cp = "cp -ivr";
    mv = "mv -iv";
    rm = "rm -vI";
    mkdir = "mkdir -pv";

    # Colorize commands when possible.
    ls = "exa --icons";
    grep = "grep --color=auto";
    diff = "diff --color=auto";
    ccat = "highlight --out-format=ansi";
    ip = "ip -color=auto";

    # shortcuts
    e = "$EDITOR";

    # utils
    find-font = "fc-list | grep ";
  };

  programs.fish = {
    functions.goToProject = ''
      set selected_folder (command ls -d ~/projects/*/ | fzf)

      if test -n "$selected_folder"
          cd "$selected_folder"
          $EDITOR
      else
          echo "No folder selected."
      end
    '';

    shellInit = pkgs.lib.mkAfter ''
      bind \cp 'goToProject; commandline -f execute'
    '';
  };

  xdg.enable = true;
}
