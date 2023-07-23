{
  description = "My nixos config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";

    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    grub2-themes.url = "github:vinceliuice/grub2-themes";
    nix-colors.url = "github:misterio77/nix-colors";
    neovim-grig.url = "github:grig-iv/neovim-flake";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    neovim-grig,
    ...
  } @ inputs: let
    nvim = neovim-grig.packages.x86_64-linux.nvim;
    mkHomeConfig = userName:
      home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {inherit (self) inputs outputs;};
        modules = [
          ./user/${userName}.nix
          { home.packages = [nvim]; }
        ];
      };
  in {
    formatter.x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;

    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./system/configuration.nix
          inputs.grub2-themes.nixosModules.default
        ];
      };
    };

    homeConfigurations = {
      grig-xm = mkHomeConfig "grig-xm";
      grig-gn = mkHomeConfig "grig-gn";
    };
  };
}
