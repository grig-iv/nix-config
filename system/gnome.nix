{pkgs, ...}: {
  services.xserver = {
    enable = true;
    autorun = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  environment = {
    gnome.excludePackages = with pkgs;
    with pkgs.gnome; [
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
