{inputs, ...}: {
  flake.nixosConfigurations = {
    xtal = inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./xtal.nix
        inputs.grub2-themes.nixosModules.default
        inputs.sops-nix.nixosModules.sops
      ];
    };
    tha = inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      modules = [
        ./tha.nix
        inputs.sops-nix.nixosModules.sops
      ];
    };
  };
}
