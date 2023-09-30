{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nix-colors.homeManagerModules.default

    ./grig-shared-desktop.nix

    ./modules/xmonad.nix
    ./modules/xmobar.nix
  ];

  home.packages = with pkgs; [
    obs-studio
    element-desktop
    qbittorrent
    inkscape
  ];
}
