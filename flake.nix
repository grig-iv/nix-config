{
  description = "My nixos config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";

    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    grub2-themes.url = "github:vinceliuice/grub2-themes";
  };

  outputs = inputs: 
  let
    mkHomeConfig = userName: inputs.home-manager.lib.homeManagerConfiguration {
      pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
      extraSpecialArgs = { inherit inputs; }; 
      modules = [ ./home/${userName}.nix ];
    };
  in 
  {
    nixosConfigurations = {
      nixos = inputs.nixpkgs.lib.nixosSystem {
        specialArgs = { inherit inputs; }; 
        modules = [ 
          ./host/configuration.nix 
          ./host/hardware-configuration.nix 
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
