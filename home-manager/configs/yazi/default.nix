{
  pkgs,
  unstable,
  ...
}: let
  catppuccin = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/yazi-rs/themes/main/catppuccin-mocha/theme.toml";
    sha256 = "POdf9fYYjqIzx2t/QR64QvWcWaJu4l6tbALbgGkzp7Q=";
  };

  icons = pkgs.writeText "icons" ''
    [icon]
    prepend_rules = [
    	{ name = "Cloud/"         , text = "󰅣" },
    	{ name = "Books/"         , text = "󱉟" },
    	{ name = "Camera/"        , text = "󰄀" },
    	{ name = "Quick Share/"   , text = "󰒗" },
    	{ name = "Extended Mind/" , text = "󰧑" },
    ]
  '';

  theme = pkgs.runCommand "theme" {} ''
    cat ${catppuccin} > $out
    cat ${icons} >> $out
  '';
in {
  programs.yazi = {
    enable = true;
    package = unstable.yazi;
    enableFishIntegration = true;
    settings = {
      manager = {
        ratio = [0 2 3];
        show_symlink = false;
        sort_by = "natural";
        sort_dir_first = true;
        sort_reverse = false;
      };
      plugin = {
        prepend_previewers = [
          {
            name = "*.md";
            exec = "glow";
          }
        ];
      };
    };
    keymap = {
      manager.prepend_keymap = [
        {
          on = ["<C-PageUp>"];
          exec = "arrow -99999999";
          desc = "Move cursor to the top";
        }
        {
          on = ["<C-PageDown>"];
          exec = "arrow 99999999";
          desc = "Move cursor to the bottom";
        }
        {
          on = ["<PageUp>"];
          exec = "arrow -50%";
          desc = "Move cursor up half page";
        }
        {
          on = ["<PageDown>"];
          exec = "arrow 50%";
          desc = "Move cursor down half page";
        }
        {
          on = ["<Enter>"];
          exec = "plugin --sync smart-enter";
          desc = "Enter the child directory, or open the file";
        }
      ];
    };
  };

  programs.fish.shellInit = pkgs.lib.mkAfter ''
    bind \ce 'ya; commandline -f execute'
  '';

  home.packages = with pkgs; [
    # ffmpegthumbnailer
    glow
  ];

  xdg.configFile = {
    "yazi/init.lua".source = ./init.lua;
    "yazi/theme.toml".source = theme;
    "yazi/plugins/glow.yazi/init.lua".source = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/Reledia/glow.yazi/main/init.lua";
      sha256 = "b5y4l2hpVDauncIsBQ+TjQt4nauoHosfOqyH2ntuRzE=";
    };
    "yazi/plugins/smart-enter.yazi/init.lua".text = ''
      return {
      	entry = function()
      		local h = cx.active.current.hovered
      		ya.manager_emit(h and h.cha.is_dir and "enter" or "open", {})
      	end,
      }
    '';
  };
}
