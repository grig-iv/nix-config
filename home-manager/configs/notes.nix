{
  config,
  pkgs,
  lib,
  ...
}: {
  home = {
    # packages = lib.mkIf (! config.my.hostInfo.isInWsl) [pkgs.obsidian]; # remove in wsl

    shellAliases = {
      m = "cd ~/Extended\\ Mind & e index.norg";
      h = "cd ~/Interlinked\\ Cells & e index.md";
    };
  };

  my.shell.bookmarks.m = "~/Extended Mind";
}
