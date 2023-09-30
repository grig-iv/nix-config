{
  config,
  pkgs,
  lib,
  ...
}: {
  home.packages = with pkgs; [
    alejandra
  ];

  home.sessionVariables = {
    NIXCONF = lib.mkDefault "/etc/nixos";
  };

  home.shellAliases = {
    x = "cd $NIXCONF & e";

    shm = "home-manager switch --flake $NIXCONF#${config.home.username}";
    snc = "sudo nixos-rebuild switch --flake $NIXCONF#nixos";
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true; # Workaround for https://github.com/nix-community/home-manager/issues/2942
  };

  programs.home-manager.enable = true;
  home.stateVersion = "23.05"; # lock. do not change
}
