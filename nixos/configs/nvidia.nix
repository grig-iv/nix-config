{config, ...}: let
  close = "nvidia";
  open = "nouveau";
  driver = close;
in {
  services.xserver.videoDrivers = [driver];

  hardware = {
    graphics = {
      enable = true;
    };

    nvidia = {
      open = false;
      modesetting.enable = driver == close; # should be true for "nvidia" and fals for "nouveau"
      forceFullCompositionPipeline = true;
    };
  };

  environment.sessionVariables = {
    LD_LIBRARY_PATH = ["${config.hardware.nvidia.package}/lib"];
  };
}
