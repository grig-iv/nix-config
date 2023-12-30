{inputs, ...}: {
  flake.nixosConfigurations = {
    xtal = inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      system = "x86_64-linux";
      modules = [
        ./xtal.nix
        inputs.grub2-themes.nixosModules.default
        inputs.sops-nix.nixosModules.sops
      ];
    };
    tha-wsl = inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      system = "x86_64-linux";
      modules = [
        ./tha-wsl.nix
        inputs.nixos-wsl.nixosModules.default
        inputs.sops-nix.nixosModules.sops
      ];
    };
  };
}
