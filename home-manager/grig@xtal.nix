{pkgs, ...}: {
  imports = [
    ./configs/shared/desktop.nix

    ./configs/awesome.nix
    ./configs/discord.nix
    ./configs/tidal-cycles.nix
    ./configs/notes.nix
    ./configs/anki.nix

    ./configs/development/clojure.nix
    ./configs/development/rust.nix
    ./configs/development/python.nix
    #    ./configs/development/dotnet.nix
    #    ./configs/development/go.nix
  ];

  my.shell.bookmarks = {
    b = "~/books";
    p = "~/projects";
    d = "~/Downloads";
    m = "~/extended-mind";
    c = "~/.config";
  };

  home.packages = with pkgs; [
    # main
    qbittorrent
    brave
    gimp
    spotify
    obs-studio
    screenkey
    audacity

    diskonaut
    foliate

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
}
