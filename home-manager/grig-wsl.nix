{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./grig-shared.nix
    ./configs/development/rust.nix

    ./configs/wsl-vpnkit.nix
    ./configs/notes.nix
  ];

  home.packages = with pkgs; [
    wslu
    age
  ];

  my.hostInfo.isInWsl = true;

  # home.activation = {
  #   copyFileTest = config.lib.dag.entryBefore ["writeBoundary"] ''
  #     cp -f ${./configs/firefox/tridactylrc} /mnt/c/Users/abstr/.config/tridactyl/tridactylrc
  #   '';
  # };

  home.shellAliases = {
    "pwsh" = "powershell.exe";
    "pwsh -c" = "powershell.exe -Command";
  };

  home.sessionVariables = {
    NIXCONF = "${config.xdg.configHome}/nix-config";
  };

  my.hostInfo.windowsUserPath = "/mnt/c/Users/abstr/";
}
