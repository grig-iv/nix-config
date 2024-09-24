{pkgs, ...}: {
  imports = [
    ./gnome.nix # i don't know why, but all works fine only if gnome also installed
    ./dwm.nix
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
    };

    libinput = {
      enable = true;
      mouse = {
        accelProfile = "flat";
        accelSpeed = "-0.25";
      };
    };
  };
}
