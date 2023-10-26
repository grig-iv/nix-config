{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nix-colors.homeManagerModules.default

    ./grig-shared-desktop.nix

    ./modules/awesome.nix
    ./modules/discord.nix
    ./modules/tidal-cycles.nix
    ./modules/notes.nix

    ./modules/development/scala.nix
    ./modules/development/ocaml.nix
  ];

  home.packages = with pkgs; [
    qbittorrent
    remmina
    diskonaut
    exercism
  ];
}
