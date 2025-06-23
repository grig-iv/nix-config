{
  pkgs,
  unstable,
  ...
}: {
  imports = [
    ./configs/sops.nix
    ./configs/ssh.nix
  ];

  home = {
    packages = with pkgs; [
      runit
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
      just
      yt-dlp
      bottom
      unstable.helix
      git-agecrypt
      age

      neovim
      ripgrep
      tree-sitter
      fd
      jq
      nodejs_20

      unstable.yazi
      glow

      tmux
      tmuxp

      qmk
      evtest
      imagemagick

      # services
      syncthing
      v2raya
      shadowsocks-rust

      # lsp & formaters
      marksman # makrdown
      taplo # toml
      yaml-language-server # yaml

      vscode-langservers-extracted # html/css/json
      unstable.typescript-language-server
      jsbeautifier
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

      # x11 + desktop
      xcolor
      xorg.xev
      xorg.xwininfo
      xbindkeys
      xkb-switch
      xdotool
      unclutter-xfixes
      sxhkd
      rofi

      vlc
      mpd
      ncmpcpp
      mpc
      ffmpeg
      mpv

      krusader
      ghostty
      zathura
      telegram-desktop
      unstable.freetube
      unstable.darktable
      qbittorrent
      tor-browser
      chromium
      gimp
      inkscape
      keepass
      # discord
      anki-bin
      v2raya

      reaper
      vital
      furnace

      gnome-boxes

      # work
      remmina
      putty
      libreoffice
      slack
    ];

    username = "grig";
    homeDirectory = "/home/grig";
    stateVersion = "24.11";
  };

  sops.secrets."shadowsocks/vps-no".path = "%r/shadowsocks/config-no.json";
  systemd.user.services.shadowsocks = {
    Unit = {
      Description = "Shadowsocks";
      After = ["network-online.target" "sops-nix.service"];
      Wants = "network-online.target";
    };
    Service = {
      Type = "simple";
      ExecStart = "${pkgs.shadowsocks-rust}/bin/sslocal -c %t/shadowsocks/config-no.json";
      Restart = "always";
      RestartSec = "5";
    };
    Install = {
      WantedBy = ["default.target"];
    };
  };

  programs.home-manager.enable = true;
  targets.genericLinux.enable = true;
  xdg.enable = true;

  manual = {
    manpages.enable = false;
  };

  systemd.user.startServices = "sd-switch";
}
