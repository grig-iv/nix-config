{
  config,
  pkgs,
  ...
}: {
  # don't know why rofi.plugins don't work
  home.packages = with pkgs; [
    rofi-emoji
    rofi-calc
    rofi-power-menu
    rofi-vpn
    rofi-rbw
    rofi-pulse-select
  ];

  programs.rofi = {
    enable = true;
    font = "${config.my.fontName} 12";
    plugins = with pkgs; [
      rofi-emoji
      rofi-calc
      rofi-power-menu
      rofi-rbw
      rofi-pulse-select
    ];

    extraConfig = {
      modi = "emoji,calc";
      show-icons = true;
      sort = true;
      matching = "fuzzy";
    };
  };
}
