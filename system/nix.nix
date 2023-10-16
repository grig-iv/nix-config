{pkgs, ...}: {
  system.stateVersion = "23.05";

  nix = {
    package = pkgs.nixFlakes;
    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
      allowed-users = ["grig-iv" "grig-gn"];
    };
    gc = {
      automatic = true;
      options = "--delete-older-than 5d";
    };
  };

  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    home-manager
  ];

  documentation.man.enable = false;
}
