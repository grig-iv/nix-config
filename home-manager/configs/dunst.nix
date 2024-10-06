# https://dunst-project.org/documentation/
{
  pkgs,
  config,
  ...
}: let
  colors = config.my.colors;
in {
  home.packages = with pkgs; [dunst];
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
        offset = "0x32";
        origin = "top-center";

        # look
        transparency = 10;
        frame_color = colors.base;
        corner_radius = config.my.fontName;
      };

      urgency_low = {
        frame_color = colors.primary;
        background = colors.base;
        foreground = colors.text;
        timeout = 1;
      };

      urgency_normal = {
        frame_color = colors.accent;
        background = colors.base;
        foreground = colors.text;
        timeout = 1;
      };

      urgency_critical = {
        frame_color = colors.critical;
        background = colors.base;
        foreground = colors.text;
        timeout = 1;
      };
    };
  };
}
