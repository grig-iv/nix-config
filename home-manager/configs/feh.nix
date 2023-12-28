{
  config,
  pkgs,
  ...
}: let
  wallpaper = pkgs.fetchurl {
    url = "https://w.wallhaven.cc/full/zx/wallhaven-zxepdo.jpg";
    sha256 = "+qPJykyumycM1xGH7fqUZYaw+S+GJanRr5EAWVcqOz8=";
  };

  set-wallpaper = pkgs.writeShellScriptBin "set-wallpaper" ''
    feh --bg-fill ${wallpaper}*
  '';
in {
  home.packages = [set-wallpaper];
  programs.feh = {
    enable = true;
  };
}
