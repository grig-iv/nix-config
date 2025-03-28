{
  pkgs,
  unstable,
  ...
}: let
  user = "grig";
in {
  imports = [
    ./modules
    ./configs/fish.nix
    ./configs/neovim.nix
    ./configs/firefox
    ./configs/dunst.nix
    ./configs/udiskie.nix
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
      runit
      unstable.helix
      stow
      lazygit
      skim
      fd
      tldr
      tree
      direnv
      curl
      wget
      unzip
      zip
      bc
      diskonaut
      just
      yt-dlp
      lf
      bottom
      calcurse
      shellcheck
      dash
      ghostty
      v2raya
      syncthing

      unstable.yazi
      glow

      tmux
      tmuxp

      rbw
      pinentry

      qmk
      evtest
      imagemagick

      # lsp & formaters
      marksman # makrdown
      taplo # toml
      yaml-language-server # yaml

      nginx
      vscode-langservers-extracted # html/css/json
      unstable.typescript-language-server
      jsbeautifier
      biome
      bun

      tailwindcss
      tailwindcss-language-server

      nil
      alejandra

      lua-language-server
      stylua

      go
      unstable.gopls
      gore

      rustup
      gcc

      pyright

      unstable.zig
      unstable.zls

      # x11 + desktop
      xclip
      xcolor
      xorg.xeyes
      xorg.xev
      xorg.xwininfo
      xbindkeys
      xdotool
      feh
      pulsemixer
      flameshot
      krusader
      dmenu
      rofi
      wezterm
      sxhkd
      unclutter
      redis
      polybar

      mpd
      ncmpcpp
      mpc
      ffmpeg

      zathura
      obsidian
      telegram-desktop
      unstable.freetube
      unstable.darktable
      qbittorrent
      tor-browser
      chromium
      gimp
      inkscape
      electrum
      keepass
      # discord
      anki-bin
      mpv
      v2raya
      texliveFull
      scribus

      ardour
      furnace

      gnome-boxes
      spice-vdagent

      # work
      remmina
      putty
      libreoffice
      skypeforlinux
      slack
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
