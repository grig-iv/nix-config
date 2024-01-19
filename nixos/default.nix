{inputs, ...}: {
  flake.nixosConfigurations = {
    xtal = inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      system = "x86_64-linux";
      modules = [./xtal.nix];
    };
    tha-wsl = inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      system = "x86_64-linux";
      modules = [./tha-wsl.nix];
    };
    work-wsl = inputs.nixpkgs.lib.nixosSystem {
      specialArgs = {inherit inputs;};
      system = "x86_64-linux";
      modules = [./work-wsl.nix];
    };
  };
}
