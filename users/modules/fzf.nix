{pkgs, ...}: {
  home.packages = with pkgs; [fd];

  programs = {
    skim.enable = true;
    fish = {
      functions = {
        goToProject = ''
          set selected_folder (command ls -d ~/projects/*/ | sk)

          if test -n "$selected_folder"
              cd "$selected_folder"
              $EDITOR
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
      };

      shellInit = pkgs.lib.mkAfter ''
        bind \cp 'goToProject; commandline -f execute'
        bind \cf 'findAndEdit'
      '';
    };
  };
}
