{
  pkgs,
  lib,
  inputs,
  ...
}: let
  dwm-exe = lib.getExe inputs.grig-dwm.packages.${pkgs.system}.dwm;
  dwm-log = "$HOME/.local/share/dwm.log";
in {
  xsession = {
    enable = true;
    windowManager.command = "${dwm-exe} &> ${dwm-log}";
    initExtra = ''
      rm ${dwm-log}
    '';
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
