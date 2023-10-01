{pkgs, ...}: {
  home.packages = with pkgs; [
    tidal
    superdirt-start
  ];
}
