{pkgs, ...}: {
  home = {
    packages = with pkgs; [
      obsidian
    ];
    shellAliases = {
      m = "cd ~/Extended\\ Mind & $EDITOR index.md";
      h = "cd ~/Interlinked\\ Cells & $EDITOR index.md";
    };
  };

  my.shell.bookmarks.m = "~/Extended Mind";
}
