{
  pkgs,
  lib,
  ...
}: {
  system.stateVersion = lib.mkDefault "23.05";

  nix = {
    package = pkgs.nixFlakes;

    settings = {
      experimental-features = ["nix-command" "flakes"];
      auto-optimise-store = true;
      builders-use-substitutes = true;
      substituters = [
        "https://cache.nixos.org"
        "https://nix-community.cachix.org"
        "https://cuda-maintainers.cachix.org"
      ];
      trusted-public-keys = [
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "cuda-maintainers.cachix.org-1:0dq3bujKpuEPMCX6U4WylrUDZ9JyUG0VpVZa7CNfq5E="
      ];
      allowed-users = ["grig-iv" "grig-gn"];
    };
    gc = {
      # automatic = true;
      options = "--delete-older-than 5d";
    };
    extraOptions = ''
      warn-dirty = false
    '';
  };

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true; # Workaround for https://github.com/nix-community/home-manager/issues/2942
  };

  environment.systemPackages = with pkgs; [
    home-manager
  ];

  documentation.man.enable = false;
}
