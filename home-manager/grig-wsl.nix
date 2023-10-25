{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./grig-shared.nix

    ./modules/wsl-vpnkit.nix
    ./modules/dotnet.nix
    ./modules/go.nix
  ];

  home.packages = with pkgs; [
    wslu
    chezmoi
    age
    qmk
  ];

  my.hostInfo.isInWsl = true;

  home.activation = {
    safeScoopList = config.lib.dag.entryBefore ["writeBoundary"] ''
      #!/usr/bin/env bash
      /mnt/c/Windows/System32/WindowsPowerShell/v1.0//powershell.exe scoop list | /usr/bin/awk '/----/,0 {if (NF && $0 !~ /----/) print $1}' > ~/extended-mind/data/scoop-list
    '';
  };

  home.shellAliases = {
    pwsh = "powershell.exe -Command";
  };

  home.sessionVariables = {
    NIXCONF = "${config.xdg.configHome}/nix-config";
  };
}
