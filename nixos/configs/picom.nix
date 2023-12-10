{...}: {
  services.picom = {
    enable = true;
    backend = "xrender";
    vSync = true;
    shadow = true;
    shadowOpacity = 0.9;
    settings = {
      corner-radius = 10.0;
      round-borders = 1;
      shadow-exclude = [
        "class_g = 'awesome'"
        "class_g = 'firefox' && argb"
      ];
    };
  };
}
