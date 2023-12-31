{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./shell.nix
    ./../wsl-vpnkit.nix
  ];

  home = {
    packages = with pkgs; [wslu];

    shellAliases = {
      "pwsh" = "powershell.exe";
      "pwshc" = "powershell.exe -Command";
    };

    sessionVariables = {
      NIXCONF = "${config.xdg.configHome}/nix-config";
    };

    # activation = {
    #   copyFileTest = config.lib.dag.entryBefore ["writeBoundary"] ''
    #     cp -f ${./configs/firefox/tridactylrc} /mnt/c/Users/abstr/.config/tridactyl/tridactylrc
    #   '';
    # };
  };

  my.hostInfo = {
    isInWsl = true;
    windowsUserPath = "/mnt/c/Users/abstr/";
  };
}
