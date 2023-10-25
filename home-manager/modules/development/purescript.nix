{pkgs, ...}: {
  home.packages = with pkgs; [
    purescript
    spago
    nodejs_20
  ];
}
