{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [flameshot];

  services.sxhkd.keybindings = {
    "super + shift + s" = "${lib.getExe pkgs.flameshot} gui";
    "print" = "${lib.getExe pkgs.flameshot} screen -c";
  };
}
