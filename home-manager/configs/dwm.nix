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

  services.dwm-status = {
    enable = true;
    order = [
      "audio"
      "time"
    ];
  };

  services.sxhkd.enable = true;
}
