{
  config,
  pkgs,
  lib,
  ...
}: {
  home = {
    packages = lib.mkIf config.my.hostInfo.isInWsl [pkgs.obsidian]; # remove in vsl

    shellAliases = {
      m = "cd ~/extended-mind & e index.norg";
      h = "cd ~/interlinked-cells & e index.md";
    };
  };
}
