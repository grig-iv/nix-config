{
  pkgs,
  config,
  lib,
  ...
}: {
  home = {
    packages = with pkgs; [wslu];

    shellAliases = {
      "pwsh" = "powershell.exe";
      "pwshc" = "powershell.exe -Command";
    };
  };

  my = {
    hostInfo = {
      isInWsl = true;
      windowsUserPath = lib.mkDefault "/mnt/c/Users/abstr/";
    };
    shell.bookmarks = {
      "w" = config.my.hostInfo.windowsUserPath;
    };
  };
}
