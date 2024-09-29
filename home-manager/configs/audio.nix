{
  pkgs,
  lib,
  ...
}: {
  services.sxhkd.keybindings = {
    "XF86Audio{Lower,Raise}Volume" = "${lib.getExe pkgs.pamixer} -{d,i} 5";
    "XF86AudioMute" = "${lib.getExe pkgs.pamixer} -t";
    "super + alt + s" = "audio-cycle-output";
  };
}
