{
  pkgs,
  config,
  ...
}: let
  colors = config.my.colors;
  theme = builtins.toFile "rofi-theme.rasi" ''
    /* taken from https://github.com/lr-tech/rofi-themes-collection */

    * {
        font:   "JetBrainsMono Nerd Font 14";

        bg0:     ${colors.mantle};
        bg1:     ${colors.base};
        bg2:     ${colors.surface0};
        fg0:     ${colors.text};

        accent-color:     ${colors.primary};
        urgent-color:     ${colors.critical};

        background-color:   transparent;
        text-color:         @fg0;

        margin:     0;
        padding:    0;
        spacing:    0;
    }

    window {
        location:   center;
        width:      500;

        background-color:   @bg0;
    }

    inputbar {
        spacing:    8px;
        padding:    8px;

        background-color:   @bg1;
    }

    prompt, entry, element-icon, element-text {
        vertical-align: 0.5;
    }

    prompt {
        text-color: @accent-color;
    }

    textbox {
        padding:            8px;
        background-color:   @bg1;
    }

    listview {
        padding:    4px 0;
        lines:      8;
        columns:    1;

        fixed-height:   true;
    }

    element {
        padding:    8px;
        spacing:    8px;
    }

    element normal normal {
        text-color: @fg0;
    }

    element normal urgent {
        text-color: @urgent-color;
    }

    element normal active {
        text-color: @accent-color;
    }

    element selected normal, element selected active {
        text-color:         @accent-color;
        background-color:   @bg2;
    }

    element selected urgent {
        text-color:         @urgent-color;
        background-color:   @bg2;
    }

    element-icon {
        size:   0.8em;
    }

    element-text {
        text-color: inherit;
    }
  '';
in {
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
    theme = theme;

    plugins = with pkgs; [
      rofi-emoji
      rofi-calc
      rofi-power-menu
      rofi-rbw
    ];

    extraConfig = {
      show-icons = true;
      sort = true;
      matching = "prefix";

      modi = "drun";
      icon-theme = "Oranchelo";
      terminal = "wezterm";
      drun-display-format = "{icon} {name}";
      location = 0;
      disable-history = false;
      hide-scrollbar = true;
      display-drun = "󱄅  ";
      sidebar-mode = false;
    };
  };
}
