{pkgs, ...}: {
  imports = [./gnome.nix]; # i don't know why, but all works fine only if gnome also installed

  programs.dconf.enable = true;

  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gnome];
  };

  services = {
    gnome.gnome-keyring.enable = true;

    dbus = {
      enable = true;
      packages = [pkgs.dconf];
    };

    xserver = {
      enable = true;

      libinput = {
        enable = true;
      };

      windowManager = {
        awesome.enable = true;
        xmonad = {
          enable = true;
          enableContribAndExtras = true;
        };
      };
    };
  };
}
