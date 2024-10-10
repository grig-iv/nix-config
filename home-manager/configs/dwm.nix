{
  pkgs,
  lib,
  inputs,
  ...
}: let
  dwm = lib.getExe inputs.grig-dwm.packages.${pkgs.system}.default;
  gost = lib.getExe inputs.grig-gost.packages.${pkgs.system}.default;
  dwm-log = "$HOME/.local/share/dwm.log";
  dwm-dev = "$HOME/sources/dwm/dwm";
  dwm-dev-log = "$HOME/sources/dwm/dwm.log";
in {
  xsession = {
    enable = true;
    windowManager.command = ''
      ${dwm} &> ${dwm-log}

      while [ -e ${dwm-dev} ]; do
          ${dwm-dev} &> ${dwm-dev-log}
          rm -f ${dwm-dev}
          ${dwm} &> ${dwm-log}
      done
    '';
    initExtra = ''
      rm ${dwm-log}
      ${gost} &
    '';
  };

  services.sxhkd.enable = true;
}
