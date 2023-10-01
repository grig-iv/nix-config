{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nix-colors.homeManagerModules.default

    ./grig-shared-desktop.nix

    ./modules/awesome.nix
    ./modules/tidal-cycles.nix
  ];

  home.packages = with pkgs; [
    obs-studio
    element-desktop
    qbittorrent
    inkscape
  ];
}
