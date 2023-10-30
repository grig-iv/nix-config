{...}: {
  programs.mpv = {
    enable = true;
    bindings = {
      "BS" = "cycle pause";
      "SPACE" = "cycle pause";

      "UP" = "add volume 2";
      "DOWN" = "add volume -2";
      "WHEEL_UP" = "add volume 2";
      "WHEEL_DOWN" = "add volume -2";

      "LEFT" = "seek -5";
      "RIGHT" = "seek +5";

      "Shift+LEFT" = "seek -60";
      "Shift+RIGHT" = "seek +60";

      "PGUP" = "add chapter -1";
      "PGDWN" = "add chapter 1";

      "S" = "cycle sub";
    };
  };
}
