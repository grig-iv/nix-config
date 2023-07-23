# https://dunst-project.org/documentation/

{config, ...}: let
  colors = config.my.colors.base16;
in {
  services.dunst = {
    enable = true;
    settings = {
      global = {
        font = "${config.my.fontName} 11";

        # Allow a small subset of html markup:
        markup = "yes";

        # Sort messages by urgency.
        sort = "yes";

        # Alignment of message text.
        alignment = "center";

        # Print a notification on startup.
        # This is mainly for error detection.
        startup_notification = true;

        # placement
        offset = "0x${toString (config.my.marginBase * 2)}";
        origin = "top-center";

        # look
        transparency = 10;
        frame_color = "#${colors.base0E}";
        corner_radius = config.my.fontName;
      };

      urgency_low = {
        #frame_color = "#268bd2";
        background = "#${colors.base00}";
        foreground = "#${colors.base05}";
        #timeout = 1;
      };

      urgency_normal = {
        #frame_color = "#b58900";
        background = "#${colors.base00}";
        foreground = "#${colors.base05}";
        #timeout = 1;
      };

      urgency_critical = {
        #frame_color = "#dc322f";
        background = "#${colors.base00}";
        foreground = "#${colors.base05}";
        #timeout = 1;
      };
    };
  };
}
