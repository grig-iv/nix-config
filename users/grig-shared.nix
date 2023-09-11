{
  config,
  pkgs,
  lib,
  ...
}:
with lib; {
  imports = [
    ./modules/my.nix
    ./modules/nix.nix
    ./modules/lf
    ./modules/git.nix
    ./modules/gitui.nix
    ./modules/fish.nix
    ./modules/tmux.nix
    ./modules/neovim.nix
  ];

  home.packages = with pkgs; [
    htop
    wget
    curl
    unzip
    tldr
    exa
    zip
  ];

  home.sessionVariables = {
    EDITOR = mkDefault "nvim";
    CONFIG = mkDefault "$HOME/.config";
    CHEZMOI = mkDefault "$HOME/.local/share/chezmoi";
    NIXCONF = mkDefault "/etc/nixos";
    NVIMCONF = mkDefault "$CONFIG/nvim";
  };

  xdg.enable = true;
  programs.home-manager.enable = true;
  home.stateVersion = "23.05"; # lock. do not change

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true; # Workaround for https://github.com/nix-community/home-manager/issues/2942
  };

  home.activation = {
    appendFishExec = config.lib.dag.entryBefore ["writeBoundary"] ''
      #!/usr/bin/env bash
      if ! grep -q "exec fish" "$HOME/.profile"; then
        echo -e "\nexec fish" >> "$HOME/.profile"
      fi
    '';
  };
}
