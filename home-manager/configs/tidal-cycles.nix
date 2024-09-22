{
  pkgs,
  inputs,
  ...
}: {
  nixpkgs.overlays = [
    inputs.tidal-cycles.overlays.tidal
  ];

  home.packages = with pkgs; [
    tidal
    superdirt-start
  ];
}
