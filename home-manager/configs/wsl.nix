{pkgs, ...}: {
  home = {
    packages = with pkgs; [wslu];

    shellAliases = {
      "pwsh" = "powershell.exe";
      "pwshc" = "powershell.exe -Command";
    };
  };

  my.hostInfo = {
    isInWsl = true;
    windowsUserPath = "/mnt/c/Users/abstr/";
  };
}
