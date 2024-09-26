{
  config,
  pkgs,
  unstable,
  ...
}: let
  user = "grig";
in {
  imports = [
    ./configs/shared/shell.nix
    ./configs/wezterm
    ./configs/firefox
    ./configs/redshift.nix
    ./configs/zathura.nix
    ./configs/rofi.nix
    ./configs/feh.nix
    ./configs/udiskie.nix
    ./configs/qmk.nix
    ./configs/mpv.nix
    ./configs/gtk.nix
    ./configs/sxiv.nix
    ./configs/discord.nix
    ./configs/notes.nix
    ./configs/anki.nix
    ./configs/ssh.nix
    ./configs/cursor.nix
    ./configs/bitwarden.nix
    ./configs/darktable.nix
    ./configs/development/go.nix
  ];

  my.shell.bookmarks = {
    b = "~/Books";
    d = "~/Downloads";
    c = "~/.config";
    p = "~/Projects";
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
      spotify
      # obs-studio
      # screenkey
      audacity
      electrum
      keepass
      unstable.freetube
      telegram-desktop
      xclip
      maim
      flameshot
      pulsemixer
      diskonaut
      calcurse
      krusader
      scribus

      st

      # work
      remmina
      putty
      libreoffice
      skypeforlinux
      slack
    ];

    stateVersion = "24.05";
  };

  news.display = "show";

  systemd.user.services.easy-mounts = {
    Unit = {
      Description = "Create link to /run/media";
    };
    Install = {
      WantedBy = ["default.target"];
    };
    Service = {
      ExecStart = "${pkgs.writeShellScript "watch-store" ''
        #!/run/current-system/sw/bin/bash
        ln -sf "/run/media/${user}" "$HOME/media"
      ''}";
    };
  };
}
