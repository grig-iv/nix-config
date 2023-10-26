{...}: {
  services.xserver.videoDrivers = ["nouveau"];

  hardware.opengl = {
    enable = true;
    driSupport = true;
  };

  hardware.nvidia = {
    modesetting.enable = false; # should be true for "nvidia" and fals for "nouveau"
  };
}
