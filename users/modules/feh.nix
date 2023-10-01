{
  config,
  pkgs,
  ...
}: let
  wallpaper = pkgs.writeShellScriptBin "set-wallpaper" ''
    feh --randomize --bg-fill ${toString config.my.backgroundsDirPath}/*nature*
  '';
in {
  home.packages = [wallpaper];
  programs.feh = {
    enable = true;
  };
}
