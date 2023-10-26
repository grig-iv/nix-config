{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nix-colors.homeManagerModules.default

    ./configs/my.nix
    ./configs/wsl-vpnkit.nix
    ./configs/fish.nix
    ./configs/git.nix
    ./configs/tmux.nix
    ./configs/neovim.nix
    ./configs/lf
    ./configs/lua.nix
    ./configs/dotnet.nix
    ./configs/syncthing.nix
  ];

  home.packages = with pkgs; [
    htop
    git
    wget
    curl
    unzip
    tldr
    exa
    wslu
    zip
    chezmoi
    age

    qmk
  ];

  my.hostInfo.isInWsl = true;

  home.activation = {
    appendFishExec = config.lib.dag.entryBefore ["writeBoundary"] ''
      #!/usr/bin/env bash
      if ! grep -q "exec fish" "$HOME/.profile"; then
        echo -e "\nexec fish" >> "$HOME/.profile"
      fi
    '';
  };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  home.shellAliases = {
    pwsh = "powershell.exe -Command";
  };

  home.sessionVariables = {
    NIXCONF = "${config.xdg.configHome}/nix-config";
  };

  colorScheme = inputs.nix-colors.colorSchemes.dracula;
}
