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

    ./configs/development/scala.nix
    ./configs/development/go.nix
  ];

  home.packages = with pkgs; [
    qbittorrent
    remmina
    diskonaut
    exercism
  ];
}
