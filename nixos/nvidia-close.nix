{...}: {
  services.xserver.videoDrivers = ["nvidia"];

  hardware.opengl = {
    enable = true;
    driSupport = true;
  };

  hardware.nvidia = {
    modesetting.enable = true; # should be true for "nvidia" and fals for "nouveau"
  };
}
