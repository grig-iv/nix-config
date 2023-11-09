{pkgs, ...}: {
  home.packages = with pkgs; [lua luajitPackages.fennel];
}
