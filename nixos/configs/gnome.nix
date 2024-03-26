{pkgs, ...}: {
  services = {
    gnome.gnome-keyring.enable = true;
    dbus.packages = [pkgs.gnome.seahorse];
    xserver = {
      enable = true;
      autorun = true;
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
  };

  environment = with pkgs; {
    systemPackages = [libsecret];
    gnome.excludePackages = with pkgs.gnome; [
      gnome-photos
      gnome-tour
      cheese
      gnome-music
      gnome-terminal
      gedit
      epiphany
      geary
      evince
      gnome-characters
      totem
      tali
      iagno
      hitori
      atomix
      gnome-contacts
      gnome-initial-setup
    ];
  };
}
