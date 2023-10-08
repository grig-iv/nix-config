{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nix-colors.homeManagerModules.default

    ./grig-shared-desktop.nix

    ./modules/awesome.nix
    ./modules/dotnet.nix
    ./modules/ocaml.nix
    ./modules/tidal-cycles.nix
  ];

  home.packages = with pkgs; [
    qbittorrent
    remmina
  ];
}
