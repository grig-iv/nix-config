{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nix-colors.homeManagerModules.default

    ./grig-shared-desktop.nix

    ./modules/awesome.nix
  ];

  home.packages = with pkgs; [
    obs-studio
    element-desktop
    qbittorrent
    inkscape
  ];
}
