{
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [flameshot];

  services.sxhkd.keybindings = {
    "super + alt + s" = "${lib.getExe pkgs.flameshot} gui";
    "print" = "${lib.getExe pkgs.flameshot} screen -c";
  };
}
