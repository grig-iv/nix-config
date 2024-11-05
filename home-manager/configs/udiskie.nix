{...}: {
  # Reqired in nixos: services.udisks2.enable = true;
  services.udiskie = {
    enable = true;
    tray = "never";
  };
}
