{pkgs, ...}: {
  imports = [
    ./configs/shared/desktop.nix

    ./configs/awesome.nix
    ./configs/discord.nix
    ./configs/tidal-cycles.nix
    ./configs/notes.nix
    ./configs/anki.nix
    ./configs/ssh.nix

    ./configs/development/clojure.nix
    ./configs/development/rust.nix
    # ./configs/development/python.nix
    #    ./configs/development/dotnet.nix
    #    ./configs/development/go.nix
  ];

  my.shell.bookmarks = {
    b = "~/Books";
    d = "~/Downloads";
    c = "~/.config";
    p = "~/projects";
  };

  home.packages = with pkgs; [
    # main
    qbittorrent
    tor-browser
    brave
    gimp
    spotify
    obs-studio
    screenkey
    audacity
    electrum
    keepass
    freetube

    diskonaut

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

  # FIXME on next reinstall
  home = {
    username = "grig-iv";
    homeDirectory = "/home/grig-iv";
    shellAliases.shm = "home-manager switch --flake $NIXCONF#grig@$(hostname)";
  };

  news.display = "show";
}
