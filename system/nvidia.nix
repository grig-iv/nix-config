{...}: {
  services.xserver.videoDrivers = ["nouveau"];

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  hardware.nvidia = {
    modesetting.enable = true;
    open = true;
  };
}
