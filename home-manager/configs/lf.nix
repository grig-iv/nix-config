{
  config,
  pkgs,
  lib,
  ...
}:
with lib;
with pkgs; let
  windowsHomeDir = config.my.hostInfo.windowsUserPath;
  isInWsl = config.my.hostInfo.isInWsl;

  copyToClipboard =
    if isInWsl
    then "win32yank.exe -i"
    else "${getExe xclip} -i -selection clipboard";

  mkCmd = cmd:
    pipe cmd [
      (x: removeSuffix "\n" x)
      (x: splitString "\n" x)
      (x: map (str: "\n  " + str) x)
      (x: concatStrings x)
      (x: "$" + "{{" + x + "\n}}\n")
    ];
in {
  imports = [./trashy.nix];

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
      mkdir = mkCmd ''
        mkdir "$@"
        lf -remote "send $id select \"$@\""
      '';

      mkfile = mkCmd ''
        touch "$@"
        lf -remote "send $id select \"$@\""
      '';

      fzf = mkCmd ''
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
      '';

      open =
        if isInWsl
        then "&wslview $f"
        else
          mkCmd ''
            case $(${getExe file} --mime-type -Lb "$f") in
              text/*|application/json|application/xml) $EDITOR "$f";;
              image/*) ${getExe' sxiv "sxiv"} "$f";;
              video/*) ${getExe mpv} --fullscreen "$f";;
              *) echo "Unknown type: $f";;
            esac
          '';

      trash = mkCmd ''${getExe trashy} "$f"'';

      select-all = ":unselect; invert";

      yank-dirname = mkCmd ''dirname -- "$f" | head -c-1 | ${copyToClipboard}'';
      yank-path = mkCmd ''printf '%s' "$fx" | ${copyToClipboard}'';
      yank-basename = mkCmd ''basename -a -- "$fx" | head -c-1 | ${copyToClipboard}'';
      yank-basename-without-extension = mkCmd ''basename -a -- "$fx" | rev | cut -d. -f2- | rev | head -c-1 | ${copyToClipboard}'';
    };

    keybindings = {
      "d" = null;
      "dl" = "trash";
      "D" = "delete";

      "y" = null;
      "yy" = "copy";
      "yp" = "yank-path";
      "yb" = "yank-basename";
      "yd" = "yank-dirname";
      "yB" = "yank-basename-without-extension";

      "f" = "fzf";

      "q" = null;
      "<c-q>" = "quit";

      "a" = "push :mkfile<space>";
      "A" = "push :mkdir<space>";

      "gwh" = "cd ${windowsHomeDir}";
      "gwd" = "cd ${windowsHomeDir}/Downloads";
      "gws" = "cd ${windowsHomeDir}/source";

      # misc
      "<c-a>" = "select-all";
      "<esc>" = "unselect";
      "x" = "cut";
      "." = "set hidden!";
      "<enter>" = "open";
      "z<space>" = "push :z<space>";
    };

    previewer = {
      keybinding = "i";
      source = getExe pistol;
    };

    extraConfig =
      ''
        set truncatechar ⋯
      ''
      + optionalString isInWsl ''
        &${ctpv}/bin/ctpv -s $id
        cmd on-quit %${getExe ctpv} -e $id
        set cleaner ${ctpv}/bin/ctpvclear
      '';
  };

  xdg.configFile = {
    "lf/colors".source = builtins.fetchurl {
      url = "https://raw.githubusercontent.com/gokcehan/lf/488294588e5e9310295d9de8e2080c9cd625cd3f/etc/colors.example";
      sha256 = "1ri9d5hdmb118sqzx0sd22fbcqjhgrp3r9xcsm88pfk3wig6b0ki";
    };
    "lf/icons".source = builtins.fetchurl {
      url = "https://raw.githubusercontent.com/gokcehan/lf/488294588e5e9310295d9de8e2080c9cd625cd3f/etc/icons.example";
      sha256 = "0hxbniw1avl02sdbjx4jdr80kbrlnbm86crfm44rfrs9bkjapda1";
    };
    "ctpv/config" = mkIf isInWsl {
      text = ''
        set force chafa
      '';
    };
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
  };

  programs.pistol = {
    enable = true;
    associations = [
      {
        mime = "image/*";
        command = "wezterm imgcat %pistol-filename% --width %pistol-extra0% --heigth %pistol-extra1% %pistol-extra2% %pistol-extra3%";
      }
    ];
  };
}
