{pkgs, ...}: {
  home = {
    packages = [pkgs.obsidian];  # remove in vsl

    shellAliases = {
      m = "cd ~/extended-mind & e index.norg";
      h = "cd ~/interlinked-cells & e index.md";
    };
  };
}
