{pkgs, ...}: {
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

      "s" = "screenshot video";
      "S" = "cycle sub";

      "Ctrl+-" = "add video-zoom -0.25";
      "Ctrl++" = "add video-zoom 0.25";
      "Ctrl+LEFT" = "add video-pan-x 0.05";
      "Ctrl+RIGHT" = "add video-pan-x -0.05";
      "Ctrl+UP" = "add video-pan-y 0.05";
      "Ctrl+DOWN" = "add video-pan-y -0.05";
    };
    config = {
      save-position-on-quit = true; # save last position
      pause = true; # start on pause
      slang = "en"; # subtitels language priority
      subs-fallback = true; # select some subtitels even if there is no match for slang
      screenshot-directory = "~/Screenshots";
    };
  };
}
