{pkgs, ...}: {
  services.xserver = {
    enable = true;
    windowManager.dwm = {
      enable = true;
      package = pkgs.dwm.overrideAttrs {
        src = ./../../src/dwm;
      };
    };
  };
}
