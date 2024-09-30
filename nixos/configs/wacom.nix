{pkgs, ...}: {
  services = {
    xserver = {
      wacom.enable = true;
      modules = [pkgs.xf86_input_wacom];
    };
  };
}
