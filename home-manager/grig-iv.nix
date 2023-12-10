{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nix-colors.homeManagerModules.default

    ./grig-shared-desktop.nix

    ./configs/awesome.nix
    ./configs/discord.nix
    ./configs/tidal-cycles.nix
    ./configs/notes.nix
    ./configs/anki.nix

    ./configs/development/scala.nix
    ./configs/development/clojure.nix
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
    qbittorrent
    brave
    gimp
    spotify
    obs-studio
    screenkey
    love
    diskonaut

    audacity

    glslviewer
    glsl_analyzer

    remmina
    putty
    libreoffice
    skypeforlinux
    slack
  ];
}
