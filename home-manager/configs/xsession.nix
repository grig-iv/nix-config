{
  pkgs,
  lib,
  inputs,
  ...
}: let
  dwm = lib.getExe inputs.grig-dwm.packages.${pkgs.system}.default;
  gost = lib.getExe inputs.grig-gost.packages.${pkgs.system}.default;
  dwm-log = "$HOME/.local/share/dwm.log";
  mind-shift-dev = "$HOME/sources/mind-shift/mind-shift";
  mind-shift-log = "$HOME/sources/mind-shift/mind-shift.log";
in {
  xsession = {
    enable = true;
    windowManager.command = ''
      if [ "$DESKTOP_SESSION" == "none+dwm" ]; then
          ${dwm} &> ${dwm-log}
      fi

      if [ "$DESKTOP_SESSION" == "none+mind-shift" ]; then
          mind-shift-st &
          mind-shift &> $HOME/.local/share/mind-shift.log
          while [ -e ${mind-shift-dev} ]; do
              mv -f ${mind-shift-dev} /tmp/mind-shift
              /tmp/mind-shift &> ${mind-shift-log}
              mind-shift &> $HOME/.local/share/mind-shift.log
          done
      fi
    '';
    initExtra = ''
      rm ${dwm-log}
      ${gost} &
    '';
  };

  home.packages = with pkgs; [
    xorg.xeyes
    xorg.xev
  ];

  services.sxhkd.enable = true;
}
