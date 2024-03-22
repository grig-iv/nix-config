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
        visibility_rules = [
          {
            dir = "~/";
            hide = [
              "go"
              "steam"
            ];
            show = [
              "\.config"
            ];
          }
        ];
      };
      plugin = {
        prepend_previewers = [
          {
            name = "*.md";
            run = "glow";
          }
        ];
      };
      opener = {
        edit = [
          {
            run = ''$EDITOR "$@"'';
            desc = "$EDITOR";
            block = true;
          }
        ];
        open = [
          {
            run = "xdg-open \"$@\"";
            desc = "Open";
          }
        ];
        reveal = [
          {
            run = ''exiftool "$1"; echo "Press enter to exit"; read _'';
            block = true;
            desc = "Show EXIF";
          }
        ];
        extract = [
          {
            run = "unar \"$1\"";
            desc = "Extract here";
          }
        ];
        play = [
          {
            run = "mpv \"$@\"";
            orphan = true;
          }
          {
            run = ''mediainfo "$1"; echo "Press enter to exit"; read _'';
            block = true;
            desc = "Show media info";
          }
        ];
        books = [
          {
            run = ''zathura "$0"'';
            desc = "Open a book";
            orphan = true;
          }
        ];
      };
      open = {
        rules = [
          {
            mime = "application/pdf";
            use = "books";
          }
          {
            mime = "application/epub+zip";
            use = "books";
          }
          {
            name = "*/";
            use = ["edit" "open" "reveal"];
          }
          {
            mime = "text/*";
            use = ["edit" "reveal"];
          }
          {
            mime = "image/*";
            use = ["open" "reveal"];
          }
          {
            mime = "video/*";
            use = ["play" "reveal"];
          }
          {
            mime = "audio/*";
            use = ["play" "reveal"];
          }
          {
            mime = "inode/x-empty";
            use = ["edit" "reveal"];
          }

          {
            mime = "application/json";
            use = ["edit" "reveal"];
          }
          {
            mime = "*/javascript";
            use = ["edit" "reveal"];
          }

          {
            mime = "application/zip";
            use = ["extract" "reveal"];
          }
          {
            mime = "application/gzip";
            use = ["extract" "reveal"];
          }
          {
            mime = "application/x-tar";
            use = ["extract" "reveal"];
          }
          {
            mime = "application/x-bzip";
            use = ["extract" "reveal"];
          }
          {
            mime = "application/x-bzip2";
            use = ["extract" "reveal"];
          }
          {
            mime = "application/x-7z-compressed";
            use = ["extract" "reveal"];
          }
          {
            mime = "application/x-rar";
            use = ["extract" "reveal"];
          }
          {
            mime = "application/xz";
            use = ["extract" "reveal"];
          }

          {
            mime = "*";
            use = ["open" "reveal"];
          }
        ];
      };
    };
    keymap = {
      manager.prepend_keymap = [
        {
          on = ["<C-PageUp>"];
          run = "arrow -99999999";
          desc = "Move cursor to the top";
        }
        {
          on = ["<C-PageDown>"];
          run = "arrow 99999999";
          desc = "Move cursor to the bottom";
        }
        {
          on = ["<PageUp>"];
          run = "arrow -50%";
          desc = "Move cursor up half page";
        }
        {
          on = ["<PageDown>"];
          run = "arrow 50%";
          desc = "Move cursor down half page";
        }
        {
          on = ["<Enter>"];
          run = "plugin --sync smart-enter";
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
