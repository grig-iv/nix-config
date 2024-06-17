{
  pkgs,
  unstable,
  ...
}: {
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
    ./configs/vscode.nix
    ./configs/mpv.nix
    ./configs/gtk.nix
    ./configs/sxiv.nix
    ./configs/awesome.nix
    ./configs/discord.nix
    ./configs/tidal-cycles.nix
    ./configs/notes.nix
    ./configs/anki.nix
    ./configs/ssh.nix
    ./configs/cursor.nix
    ./configs/bitwarden.nix
    ./configs/development/clojure.nix
    ./configs/development/rust.nix
    ./configs/development/go.nix
  ];

  my.shell.bookmarks = {
    b = "~/Books";
    d = "~/Downloads";
    c = "~/.config";
    p = "~/projects";
  };

  # FIXME on next reinstall
  home = {
    username = "grig-iv";
    homeDirectory = "/home/grig-iv";

    packages = with pkgs; [
      # main
      qbittorrent
      tor-browser
      chromium
      gimp
      spotify
      obs-studio
      screenkey
      audacity
      electrum
      keepass
      unstable.freetube
      whatsapp-for-linux
      telegram-desktop
      xclip
      maim
      pulsemixer
      diskonaut
      calcurse

      # ai
      ollama
      openai-whisper-cpp
      ffmpeg
      alsa-utils

      # work
      remmina
      putty
      libreoffice
      skypeforlinux
      slack
    ];
    shellAliases.shm = "home-manager switch --flake $NIXCONF#grig@$(hostname)";

    stateVersion = "23.05";
  };

  news.display = "show";
}
