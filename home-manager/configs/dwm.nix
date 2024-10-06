{
  pkgs,
  lib,
  inputs,
  ...
}: let
  dwm = lib.getExe inputs.grig-dwm.packages.${pkgs.system}.default;
  gost = lib.getExe inputs.grig-gost.packages.${pkgs.system}.default;
  dwm-log = "$HOME/.local/share/dwm.log";
in {
  xsession = {
    enable = true;
    windowManager.command = "${dwm} &> ${dwm-log}";
    initExtra = ''
      rm ${dwm-log}
      ${gost} &
    '';
  };

  services.sxhkd.enable = true;
}
