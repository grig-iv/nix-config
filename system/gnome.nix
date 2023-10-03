{pkgs, ...}: {
  services.xserver = {
    enable = true;
    autorun = true;
    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;
  };

  environment = {
    systemPackages = with pkgs; [gnome.gnome-tweaks];
    gnome.excludePackages =
      (with pkgs; [
        gnome-photos
        gnome-tour
      ])
      ++ (with pkgs.gnome; [
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
      ]);
  };
}
