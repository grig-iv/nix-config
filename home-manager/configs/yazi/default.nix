{pkgs, ...}: {
  programs.yazi = {
    enable = true;
    package = pkgs.yazi;
    enableFishIntegration = true;
    settings = {
      manager = {
        ratio = [0 2 3];
        show_symlink = false;
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
    "yazi/theme.toml".source = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/yazi-rs/themes/main/catppuccin-mocha/theme.toml";
      sha256 = "zGCUtlyA1k7S+VivPHv7tMt4GgE4UcYyiKfeH35/TFI=";
    };
    "yazi/plugins/glow.yazi/init.lua".source = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/Reledia/glow.yazi/main/init.lua";
      sha256 = "b5y4l2hpVDauncIsBQ+TjQt4nauoHosfOqyH2ntuRzE=";
    };
  };
}
