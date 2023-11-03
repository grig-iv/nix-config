{
  config,
  pkgs,
  lib,
  ...
}:
with lib; with pkgs; let
  windowsHomeDir = config.my.hostInfo.windowsUserPath;
in {
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
            mkdir "$@"
            lf -remote "send $id select \"$@\""
          }}
        '';

        mkfile = ''
          ''${{
            touch "$@"
            lf -remote "send $id select \"$@\""
          }}
        '';

        fzf = ''
          ''${{
            res="$(${getExe fd} -d 1 | ${getExe skim} --reverse --header='Jump to location')"
            if [ -n "$res" ]; then
                if [ -d "$res" ]; then
                    cmd="cd"
                else
                    cmd="select"
                fi
                res="$(printf '%s' "$res" | sed 's/\\/\\\\/g;s/"/\\"/g')"
                lf -remote "send $id $cmd \"$res\""
            fi
          }}
        '';

        open =
          if config.my.hostInfo.isInWsl
          then "&wslview $f"
          else ''
            ''${{
              case $(${getExe file} --mime-type -Lb $f) in
                application/json|application/xml|text/*)
                  $EDITOR "$f"
                  ;;
                image/*)
                  ${getExe sxiv} "$f"
                  ;;
                *)
                  xdg-open "$f"
                  ;;
              esac
            }}
          '';

        z = "&wslview $f"; # fix

        trash = "${getExe trashy} $f";

        yank-dirname = "$dirname -- \"$f\" | head -c-1 | xclip -i -selection clipboard";
        yank-path = "$printf '%s' \"$fx\" | xclip -i -selection clipboard";
        yank-basename = "$basename -a -- $fx | head -c-1 | xclip -i -selection clipboard";
        yank-basename-without-extension = "&basename -a -- $fx | rev | cut -d. -f2- | rev | head -c-1 | xclip -i -selection clipboard";
      };

      keybindings = {
        "x" = "cut";
        "d" = null;
        "dl" = "trash";
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

        "gwh" = "cd ${windowsHomeDir}";
        "gwd" = "cd ${windowsHomeDir}/Downloads";
        "gws" = "cd ${windowsHomeDir}/source";

        "gp" = "cd ~/projects";
        "gm" = "cd ~/extended-mind";
        "gc" = "cd ~/.config";
        "gx" = "cd ~/.config/nix-config";
        "gn" = "cd ~/.config/nvim";
        "f" = "fzf";
      };

      previewer = mkIf config.my.lf.ctpv.enable {
        keybinding = "i";
        source = "${ctpv}/bin/ctpv";
      };

      extraConfig =
        ''
          set truncatechar ⋯
        ''
        + optionalString config.my.lf.ctpv.enable ''
          &${ctpv}/bin/ctpv -s $id
          cmd on-quit %${ctpv}/bin/ctpv -e $id
          set cleaner ${ctpv}/bin/ctpvclear
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
