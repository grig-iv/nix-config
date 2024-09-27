{
  pkgs,
  lib,
  inputs,
  ...
}: {
  xsession = {
    enable = true;
    windowManager.command = lib.getExe inputs.grig-dwm.packages.${pkgs.system}.dwm;
  };

  services.sxhkd.enable = true;
}
