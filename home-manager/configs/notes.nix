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

  my.shell.bookmarks = [
    {
      path = "~/Extended Mind";
      binding = "m";
    }
  ];
}
