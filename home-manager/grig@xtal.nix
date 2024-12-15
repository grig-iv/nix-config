{
  pkgs,
  unstable,
  ...
}: let
  user = "grig";
in {
  imports = [
    ./modules
    ./configs/nix.nix
    ./configs/yazi
    ./configs/skim.nix
    ./configs/bat.nix
    ./configs/git.nix
    ./configs/fish.nix
    ./configs/bash.nix
    ./configs/tmux.nix
    ./configs/neovim.nix
    ./configs/direnv.nix
    ./configs/wezterm
    ./configs/firefox
    ./configs/dmenu.nix
    ./configs/dunst.nix
    ./configs/udiskie.nix
    ./configs/gtk.nix
    ./configs/ssh
    ./configs/audio.nix
    ./configs/cursor.nix
    ./configs/bitwarden.nix
    ./configs/development/go.nix
  ];

  programs.fish = {
    functions.transcend-dev = ''
      set dir $(pwd)
      cd "$(go run . --dir $dir --print-last-dir)"

      set tmp (mktemp -t "transcend-cwd.XXXXX")
      cd ~/sources/transcend
      go run . $argv --cwd-file="$tmp"
      if set cwd (cat -- "$tmp"); and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
          cd -- "$cwd"
      end
      rm -f -- "$tmp" &2> /dev/null
    '';
    shellInit = pkgs.lib.mkAfter ''
      bind \ct 'transcend-dev; commandline -f repaint'
    '';
  };

  my = {
    shell.bookmarks = [
      {
        path = "~/Books";
        binding = "b";
      }
      {
        path = "~/Downloads";
        binding = "d";
      }
      {
        path = "~/.config";
        binding = "c";
      }
      {
        path = "~/sources";
        binding = "s";
      }
      {
        path = "~/media/T7/torrents";
        binding = "t";
      }
    ];

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

  services.sxhkd.enable = true;

  services.sxhkd.keybindings = let
    cmd = x: ''bash -c "echo '${x}' > /dev/tcp/127.0.0.1/10005"'';
  in {
    "super + alt + ctrl + q" = cmd "quit";
    "super + alt + q" = cmd "kill-client";
    "super + alt + f" = cmd "full-screen";

    "super + Up" = cmd "focus -p";
    "super + Down" = cmd "focus -n";

    "super + ctrl + Prior" = cmd "go-to-tag -p";
    "super + ctrl + Next" = cmd "go-to-tag -n";

    "super + ctrl + shift + Prior" = cmd "move-to-tag -p";
    "super + ctrl + shift + Next" = cmd "move-to-tag -n";

    "super + t" = cmd "go-to-win-or-spawn org.wezfu wezterm";
    "super + f" = cmd "go-to-win-or-spawn firefox firefox";
    "super + s" = cmd "go-to-win-or-spawn TelegramDesktop telegram-desktop";

    "super + shift + s" = "flameshot gui";
    "print" = "flameshot screen -c";

    "super + alt + c" = "xcolor -s";
  };

  xdg.enable = true;
}
