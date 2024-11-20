{
  pkgs,
  unstable,
  ...
}: let
  user = "grig";
in {
  imports = [
    ./configs/shared/shell.nix
    ./configs/xsession.nix
    ./configs/mind-shift.nix
    ./configs/wezterm
    ./configs/firefox
    ./configs/dmenu.nix
    ./configs/dunst.nix
    ./configs/zathura.nix
    ./configs/redshift.nix
    ./configs/rofi.nix
    ./configs/feh.nix
    ./configs/udiskie.nix
    ./configs/qmk.nix
    ./configs/flameshot.nix
    ./configs/mpv.nix
    ./configs/gtk.nix
    ./configs/sxiv.nix
    ./configs/discord.nix
    ./configs/notes.nix
    ./configs/anki.nix
    ./configs/ssh
    ./configs/audio.nix
    ./configs/cursor.nix
    ./configs/bitwarden.nix
    ./configs/darktable.nix
    ./configs/bottom.nix
    ./configs/xcolor.nix
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
      # main
      qbittorrent
      tor-browser
      chromium
      gimp
      electrum
      keepass
      unstable.freetube
      telegram-desktop
      xclip
      maim
      pulsemixer
      diskonaut
      calcurse
      krusader
      yt-dlp

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

    shellAliases = {
      "s" = "jump -d ~/sources/";
    };
  };

  news.display = "show";

  systemd.user.services.easy-mounts = {
    Unit.Description = "Create link to /run/media";
    Install.WantedBy = ["default.target"];
    Service.ExecStart = "${pkgs.writeShellScript "watch-store" ''
      #!/run/current-system/sw/bin/bash
      ln -sf "/run/media/${user}" "$HOME/media"
    ''}";
  };
}
