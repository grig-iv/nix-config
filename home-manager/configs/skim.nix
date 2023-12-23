{pkgs, ...}: {
  home = {
    packages = [pkgs.fd];
    sessionVariables = {
      SKIM_DEFAULT_OPTIONS = "--color=fg:#cdd6f4,bg:#1e1e2e,matched:#313244,matched_bg:#f2cdcd,current:#cdd6f4,current_bg:#45475a,current_match:#1e1e2e,current_match_bg:#f5e0dc,spinner:#a6e3a1,info:#cba6f7,prompt:#89b4fa,cursor:#f38ba8,selected:#eba0ac,header:#94e2d5,border:#6c7086";
    };
  };

  programs = {
    skim.enable = true;
    fish = {
      functions = {
        goToProject = ''
          set selected_folder (command ls -d ~/projects/*/ | sk)

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
