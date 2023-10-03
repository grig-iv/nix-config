{pkgs, ...}: {
  services.picom = {
    enable = false; # can figure out how to make thing work properly in my setup
    package = pkgs.picom-jonaburg;

    backend = "xrender"; # one of “egl”, “glx”, “xrender”, “xr_glx_hybrid"
    vSync = true;
    shadow = true;
    shadowOpacity = 0.9;
    settings = {
      "corner-radius" = 10.0;
      "round-borders" = 1;
    };
  };
}
