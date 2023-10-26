{inputs, ...}: {
  flake.nixosConfigurations = {
    nixos = inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./configs/configuration.nix
        inputs.grub2-themes.nixosModules.default
        inputs.sops-nix.nixosModules.sops
      ];
    };
  };
}
