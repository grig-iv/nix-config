{
  pkgs,
  lib,
  inputs,
  ...
}: {
  xsession = {
    enable = true;
    windowManager.command = lib.getExe inputs.grig-dwm.packages.${pkgs.system}.dwm;
    initExtra = ''echo "test" > $HOME/test'';
  };

  services.sxhkd.enable = true;
}
