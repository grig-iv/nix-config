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
    package = pkgs.dwm-status.override {enableNetwork = false;};
    order = [
      "audio"
      "time"
    ];
    extraConfig = {
      separator = " | ";
      time.format = "%d %A %H:%M";
      audio.template = " 󰕾 {VOL}%";
    };
  };

  home.packages = with pkgs; [
    alsa-utils
  ];

  services.sxhkd.enable = true;
}
