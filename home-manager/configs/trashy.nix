{
  pkgs,
  lib,
  ...
}: let
  fzf = lib.getExe pkgs.skim;
in {
  home.packages = [pkgs.trashy];
  programs.fish = {
    functions = {
      trash-restore = ''
        trash list | ${fzf} --multi | awk '{$1=$1;print}' | rev | cut -d ' ' -f1 | rev | xargs trash restore --match=exact --force
      '';
      trash-empty = ''
        trash list | ${fzf} --multi | awk '{$1=$1;print}' | rev | cut -d ' ' -f1 | rev | xargs trash empty --match=exact --force
      '';
    };
  };
}
