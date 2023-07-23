{
  config,
  lib,
  pkgs,
  ...
}: {
  boot = {
    initrd.kernelModules = ["nvidia"];
    extraModulePackages = [config.boot.kernelPackages.nvidia_x11];
  };

  # Tell Xorg to use the nvidia driver
  services.xserver.videoDrivers = ["nvidia"];

  # Make sure opengl is enabled
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
  };

  hardware.nvidia = {
    # Modesetting is needed for most wayland compositors
    modesetting.enable = true;

    # Use the open source version of the kernel module
    open = true;
  };
}
