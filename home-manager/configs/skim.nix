{
  pkgs,
  lib,
  config,
  ...
}: let
  colors = config.my.colors;
in {
  home = {
    packages = [pkgs.fd];
    sessionVariables = {
      "SKIM_DEFAULT_OPTIONS" =
        "--color="
        + lib.concatStringsSep "," [
          ("fg:" + colors.text)
          ("bg:" + "empty")
          ("matched:" + colors.primary)
          ("matched_bg:" + colors.base)
          ("current:" + colors.accent)
          ("current_bg:" + colors.surface0)
          ("current_match:" + colors.base)
          ("current_match_bg:" + colors.primary)
          ("spinner:" + colors.green)
          ("info:" + colors.subtext1)
          ("prompt:" + colors.text)
          ("cursor:" + colors.accent)
          ("selected:" + colors.maroon)
          ("header:" + colors.teal)
          ("border:" + colors.overlay0)
        ]
        + " --bind 'ctrl-q:abort'";
    };
  };

  programs = {
    skim = {
      enable = true;
      enableFishIntegration = false;
    };
    fish = {
      functions = {
        goToProject = ''
          set selected_folder (command ls -d ~/Projects/*/ | sk)

          if test -n "$selected_folder"
              cd "$selected_folder"
          else
              echo "No folder selected."
          end
        '';
        findAndEdit = ''
          set selected_file (fd | sk)

          if test -n "$selected_file"
              $EDITOR "$selected_file"
          else
              echo "No file selected."
          end
        '';
        killProcess = ''
          ps -u $(whoami) --no-headers -o pid,cmd | sed -E 's|/nix/store/[a-z0-9]+-||g' | sed 's/^[ \t]*//' | sk | awk '{print $1}' | xargs kill
        '';
      };

      shellInit = pkgs.lib.mkAfter ''
        bind \cp 'goToProject; commandline -f execute'
        bind \cf 'findAndEdit'
        bind \ck 'killProcess'
      '';
    };
  };
}
