{
  pkgs,
  unstable,
  ...
}: let
  user = "grig";
in {
  imports = [
    ./modules
    ./configs/yazi
    ./configs/bat.nix
    ./configs/git.nix
    ./configs/fish.nix
    ./configs/tmux.nix
    ./configs/neovim.nix
    ./configs/firefox
    ./configs/dunst.nix
    ./configs/udiskie.nix
    ./configs/ssh
    ./configs/cursor.nix
  ];

  my = {
    repositories = [
      {
        url = "git@github.com:grig-iv/nvim.git";
        path = "$HOME/.config/nvim";
      }
      {
        url = "git@github.com:grig-iv/dotfiles.git";
        path = "$HOME/.config/dotfiles";
      }
      {
        url = "git@github.com:grig-iv/grog.git";
        path = "$HOME/sources/grog";
      }
      {
        url = "git@github.com:grig-iv/dwm.git";
        path = "$HOME/sources/dwm";
      }
      {
        url = "git@github.com:grig-iv/gost.git";
        path = "$HOME/sources/gost";
      }
    ];
  };

  home = {
    username = user;
    homeDirectory = "/home/${user}";

    packages = with pkgs; [
      dash
      wget
      curl
      unzip
      tldr
      zip
      tree
      bc
      diskonaut
      calcurse
      yt-dlp
      stow
      lazygit
      lf
      unstable.helix
      tmux
      tmuxp
      bottom
      fd
      skim
      direnv

      rbw
      pinentry

      qmk
      evtest

      # lsp & formaters
      marksman # makrdown
      taplo # toml
      vscode-langservers-extracted # html/css/json
      yaml-language-server # yaml

      nil
      alejandra

      lua-language-server
      stylua

      go
      unstable.gopls
      gore

      # x11 + desktop
      xclip
      xcolor
      xorg.xeyes
      xorg.xev
      feh
      pulsemixer
      flameshot
      krusader
      dmenu
      wezterm
      sxhkd
      unclutter

      zathura
      obsidian
      telegram-desktop
      unstable.freetube
      unstable.darktable
      qbittorrent
      tor-browser
      chromium
      gimp
      electrum
      keepass
      discord
      anki-bin
      mpv

      gnome.gnome-boxes
      spice-vdagent

      # work
      remmina
      putty
      libreoffice
      skypeforlinux
      slack

      #tmp
      st
      spotify
      audacity
      # obs-studio
      # screenkey
    ];

    stateVersion = "24.05";
  };

  xsession = {
    enable = true;
    windowManager.command = ''
      . $HOME/.config/x11/xsession.sh
    '';
  };

  manual = {
    manpages.enable = false;
  };

  systemd.user.startServices = "sd-switch";

  xdg.enable = true;
}
