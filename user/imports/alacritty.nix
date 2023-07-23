{config, ...}: let
  colors = config.colorScheme.colors;
in {
  programs.alacritty.enable = true;
  programs.alacritty.settings = {
    env.TERM = "xterm-256color";
    window = {
      padding = {
        x = 6;
        y = 6;
      };
      dynamic_padding = true;
      opacity = 0.9;
    };
    scrolling = {
      history = 5000;
    };
    font = {
      normal = {
        family = "JetBrainsMono Nerd Font";
        style = "Regular";
      };
      bold = {
        family = "JetBrainsMono Nerd Font";
        style = "Bold";
      };
      italic = {
        family = "JetBrainsMono Nerd Font";
        style = "Italic";
      };
      bold_italic = {
        family = "JetBrainsMono Nerd Font";
        style = "Bold Italic";
      };
      size = 11;
      offset = {
        x = 0;
        y = 0;
      };
    };
    draw_bold_text_with_bright_colors = true;
    colors = {
      primary = {
        background = "#${colors.base00}";
        foreground = "#${colors.base05}";
      };
      cursor = {
        text = "CellBackground";
        cursor = "CellForeground";
      };
      vi_mode_cursor = {
        text = "CellBackground";
        cursor = "CellForeground";
      };
      search = {
        matches = {
          foreground = "#44475a";
          background = "#50fa7b";
        };
        focused_match = {
          foreground = "#44475a";
          background = "#ffb86c";
        };
      };
      line_indicator = {
        foreground = "None";
        background = "None";
      };
      selection = {
        text = "CellForeground";
        background = "#${colors.base02}";
      };
      normal = {
        black = "#000000";
        red = "#ff5555";
        green = "#50fa7b";
        yellow = "#f1fa8c";
        blue = "#bd93f9";
        magenta = "#ff79c6";
        cyan = "#8be9fd";
        white = "#bfbfbf";
      };
      bright = {
        black = "#4d4d4d";
        red = "#ff6e67";
        green = "#5af78e";
        yellow = "#f4f99d";
        blue = "#caa9fa";
        magenta = "#ff92d0";
        cyan = "#9aedfe";
        white = "#e6e6e6";
      };
      dim = {
        black = "#14151b";
        red = "#ff2222";
        green = "#1ef956";
        yellow = "#ebf85b";
        blue = "#4d5b86";
        magenta = "#ff46b0";
        cyan = "#59dffc";
        white = "#e6e6d1";
      };
    };
    visual_bell = {
      animation = "EaseOutExpo";
      duration = 1000;
      color = "#ffffff";
    };
    key_bindings = [
      {
        key = "C";
        mods = "Control";
        action = "Copy";
      }
      {
        key = "V";
        mods = "Control";
        action = "Paste";
      }
      {
        key = "C";
        mods = "Alt";
        chars = "\\x03";
      }
      {
        key = "P";
        mods = "Alt";
        chars = "\\x16";
      }
      {
        key = "Paste";
        mods = "None";
        action = "Paste";
      }
      {
        key = "Copy";
        mods = "None";
        action = "Copy";
      }
      {
        key = "Insert";
        mods = "Alt";
        action = "PasteSelection";
      }
      {
        key = "Key0";
        mods = "Alt";
        action = "ResetFontSize";
      }
      {
        key = "Equals";
        mods = "Alt";
        action = "IncreaseFontSize";
      }
      {
        key = "Plus";
        mods = "Alt";
        action = "IncreaseFontSize";
      }
      {
        key = "Minus";
        mods = "Alt";
        action = "DecreaseFontSize";
      }
      {
        key = "F11";
        mods = "None";
        action = "ToggleFullscreen";
      }
      {
        key = "L";
        mods = "Alt";
        action = "ClearLogNotice";
      }
      {
        key = "L";
        mods = "Alt";
        chars = "\\x0c";
      }
      {
        key = "Up";
        mods = "Alt";
        action = "ScrollLineUp";
      }
      {
        key = "Down";
        mods = "Alt";
        action = "ScrollLineDown";
      }
      {
        key = "PageUp";
        mods = "Alt";
        action = "ScrollPageUp";
      }
      {
        key = "PageDown";
        mods = "Alt";
        action = "ScrollPageDown";
      }
      {
        key = "PageUp";
        mods = "Alt | Control";
        action = "ScrollToTop";
      }
      {
        key = "PageDown";
        mods = "Alt | Control";
        action = "ScrollToBottom";
      }
      {
        key = "Tab";
        mods = "Control";
        chars = "\\u001b[9;5u";
      }
      {
        key = "Tab";
        mods = "Control | Shift";
        chars = "\\u001b[9;6u";
      }
    ];
  };
}
