{
  config,
  pkgs,
  ...
}: let
  my = config.my;
  mytheme = builtins.toFile "rofi-theme.rasi" ''
    /*******************************************************************************
    * ROUNDED THEME FOR ROFI
    * User                 : LR-Tech
    * Theme Repo           : https://github.com/lr-tech/rofi-themes-collection
    *******************************************************************************/

    * {
        bg0:    #${my.colors.base16.base00};
        bg1:    #2A2A2A;
        bg2:    #3D3D3D80;
        bg3:    #${my.colors.base16.base0E};
        fg0:    #${my.colors.base16.base05};
        fg1:    #FFFFFF;
        fg2:    #969696;
        fg3:    #3D3D3D;
    }

    * {
        font:   "${my.fontName} 12";

        background-color:   transparent;
        text-color:         @fg0;

        margin:     0px;
        padding:    0px;
        spacing:    0px;
    }

    window {
        location:       center;
        width:          480;
        border-radius:  24px;

        background-color:   @bg0;
    }

    mainbox {
        padding:    12px;
    }

    inputbar {
        background-color:   @bg1;
        border-color:       @bg3;

        border:         2px;
        border-radius:  16px;

        padding:    8px 16px;
        spacing:    8px;
        children:   [ prompt, entry ];
    }

    prompt {
        text-color: @fg2;
    }

    entry {
        placeholder:        "Search";
        placeholder-color:  @fg3;
    }

    message {
        margin:             12px 0 0;
        border-radius:      16px;
        border-color:       @bg2;
        background-color:   @bg2;
    }

    textbox {
        padding:    8px 24px;
    }

    listview {
        background-color:   transparent;

        margin:     12px 0 0;
        lines:      8;
        columns:    1;

        fixed-height: false;
    }

    element {
        padding:        8px 16px;
        spacing:        8px;
        border-radius:  16px;
    }

    element normal active {
        text-color: @bg3;
    }

    element selected normal, element selected active {
        background-color:   @bg3;
    }

    element-icon {
        size:           1em;
        vertical-align: 0.5;
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
    theme = mytheme;

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