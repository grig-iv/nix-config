{
  config,
  pkgs,
  lib,
  ...
}:
with lib; {
  options.my.lf.ctpv.enable = mkEnableOption "Enalbe ctpv - file previewer for a terminal";

  config = {
    programs.lf = {
      enable = true;

      settings = {
        drawbox = true;
        hidden = false;
        ignorecase = true;
        incsearch = true;
        icons = true;
        ratios = "1:2";
        shellopts = "-eu";
      };

      commands = {
        mkdir = ''
          ''${{
              ${pkgs.coreutils}/bin/mkdir "$@"
              lf -remote "send $id select \"$@\""
          }}
        '';

        mkfile = ''
          ''${{
              ${pkgs.coreutils}/bin/touch "$@"
              lf -remote "send $id select \"$@\""
          }}
        '';

        # TODO add condition that checks if it is a wsl config
        open = "&wslview $f";

        z = ''
          ''${{
            result="$(${pkgs.zoxide}/bin/zoxide query --exclude $PWD $@)"
            lf -remote "send $id cd \"$result\""
          }}
        '';

        yank-dirname = "$dirname -- \"$f\" | head -c-1 | xclip -i -selection clipboard";
        yank-path = "$printf '%s' \"$fx\" | xclip -i -selection clipboard";
        yank-basename = "$basename -a -- $fx | head -c-1 | xclip -i -selection clipboard";
        yank-basename-without-extension = "&basename -a -- $fx | rev | cut -d. -f2- | rev | head -c-1 | xclip -i -selection clipboard";
      };

      keybindings = {

        "x" = "cut";
        "d" = "delete";
        "<delete>" = "delete";
        "y" = null;
        "yy" = "copy";
        "q" = null;
        "<c-q>" = "quit";
        "yp" = "yank-path";
        "." = "set hidden!";
        "<enter>" = "open";
        "z<space>" = "push :z<space>";
        "a" = "push :mkfile<space>";
        "A" = "push :mkdir<space>";

        "gw" = "cd /mnt/c/Users/grig";
        "gd" = "cd /mnt/c/Users/grig/Downloads";
        "gp" = "cd ~/projects";
        "gm" = "cd ~/extended-mind";
        "gc" = "cd ~/.config";
        "gx" = "cd ~/.config/nix-config";
        "gn" = "cd ~/.config/nvim";
      };

      previewer = mkIf config.my.lf.ctpv.enable {
        keybinding = "i";
        source = "${pkgs.ctpv}/bin/ctpv";
      };

      extraConfig =
        ''
          set truncatechar ⋯
        ''
        + optionalString config.my.lf.ctpv.enable ''
          &${pkgs.ctpv}/bin/ctpv -s $id
          cmd on-quit %${pkgs.ctpv}/bin/ctpv -e $id
          set cleaner ${pkgs.ctpv}/bin/ctpvclear
        '';
    };

    xdg.configFile."lf/colors".source = ./colors;
    xdg.configFile."lf/icons".source = ./icons;
    xdg.configFile."ctpv/config" = mkIf config.my.lf.ctpv.enable {
      text = ''
        set forcechafa
      '';
    };

    # lfcd (cd to current directory on lf exit)
    programs.fish = {
      functions.lfcd = ''
        set tmp (mktemp)
        command lf -last-dir-path=$tmp $argv
        if test -f "$tmp"
            set dir (cat $tmp)
            rm -f $tmp > /dev/null 2>&1
            if test -d "$dir"
                if test "$dir" != (pwd)
                    cd $dir
                end
            end
        end
      '';

      shellAliases = {
        lf = "lfcd";
      };

      shellInit = pkgs.lib.mkAfter ''
        bind \ce 'lfcd; commandline -f execute'
      '';
    };
  };
}
