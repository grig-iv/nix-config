{pkgs, ...}: {
  services.picom = {
    enable = true;
    package = pkgs.picom-jonaburg;

#    backend = "egl"; # one of “egl”, “glx”, “xrender”, “xr_glx_hybrid"
    vSync = true;
    shadow = true;
    shadowOpacity = 0.9;
    fade = true;
    fadeDelta = 5;
/*    settings = {
      "corner-radius" = 10.0;
      "round-borders" = 1;
    };*/
  };
}
