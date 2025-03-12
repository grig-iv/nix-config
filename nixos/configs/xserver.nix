{pkgs, ...}: {
  imports = [
    ./gnome.nix # i don't know why, but all works fine only if gnome also installed
  ];

  programs.dconf.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gnome];
  };

  services = {
    dbus = {
      enable = true;
      packages = [pkgs.dconf];
    };

    xserver = {
      enable = true;
      xautolock.enable = false;
      windowManager.qtile.enable = true;
      desktopManager = {
        xfce.enable = true;
      };
    };

    libinput = {
      enable = true;
      mouse = {
        accelProfile = "flat";
        accelSpeed = "-0.25";
      };
    };
  };

  environment.systemPackages = with pkgs; [xkb-switch];
}
