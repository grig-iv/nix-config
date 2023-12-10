{...}: let
  close = "nvidia";
  open = "nouveau";
  driver = close;
in {
  services.xserver.videoDrivers = [driver];

  hardware = {
    opengl = {
      enable = true;
      driSupport = true;
    };

    nvidia = {
      modesetting.enable = driver == close; # should be true for "nvidia" and fals for "nouveau"
      forceFullCompositionPipeline = true;
    };
  };
}
