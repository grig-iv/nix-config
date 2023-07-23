{config, pkgs, ...}:{
  services.picom = {
    enable = true;
    package = [pkgs.picom-jonaburg];

    vSync = true;
    shadow = true;
    fade = true;
  };
}
