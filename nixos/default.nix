{inputs, ...}: {
  flake.nixosConfigurations = {
    nixos = inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./configuration.nix
        inputs.grub2-themes.nixosModules.default
        inputs.sops-nix.nixosModules.sops
      ];
    };
  };
}
