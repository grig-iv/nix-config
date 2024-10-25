{
  pkgs,
  lib,
  inputs,
  ...
}: let
  dwm = lib.getExe inputs.grig-dwm.packages.${pkgs.system}.default;
  gost = lib.getExe inputs.grig-gost.packages.${pkgs.system}.default;
  dwm-log = "$HOME/.local/share/dwm.log";
  mind-shift = "$HOME/sources/mind-shift/mind-shift";
  mind-shift-log = "$HOME/sources/mind-shift/mind-shift.log";
in {
  xsession = {
    enable = true;
    windowManager.command = ''
      ${dwm} &> ${dwm-log}

      while [ -e ${mind-shift} ]; do
          mv -f ${mind-shift} /tmp/mind-shift
          /tmp/mind-shift &> ${mind-shift-log}
          ${dwm} &> ${dwm-log}
      done
    '';
    initExtra = ''
      rm ${dwm-log}
      ${gost} &
    '';
  };

  home.packages = with pkgs; [xorg.xeyes];

  services.sxhkd.enable = true;
}
