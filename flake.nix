{
  description = "My nixos config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager/release-23.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nur.url = "github:nix-community/NUR";
    sops-nix.url = "github:Mic92/sops-nix";
    grub2-themes.url = "github:vinceliuice/grub2-themes";
    nix-colors.url = "github:misterio77/nix-colors";
    tidal-cycles.url = "github:mitchmindtree/tidalcycles.nix";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";

    flake-parts.url = "github:hercules-ci/flake-parts";
  };

  outputs = inputs: let
    mkHomeConfig = userName:
      inputs.home-manager.lib.homeManagerConfiguration {
        pkgs = inputs.nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {
          inherit (inputs.self) inputs outputs;
          unstable = import inputs.nixpkgs-unstable {
            system = "x86_64-linux";
            config.allowUnfree = true;
          };
        };
        modules = [
          ./home-manager/${userName}.nix
          {
            nixpkgs.overlays = [
              inputs.nur.overlay
              inputs.tidal-cycles.overlays.tidal
              inputs.nix-vscode-extensions.overlays.default
            ];
            home.username = userName;
            home.homeDirectory = "/home/${userName}";
          }
        ];
      };
  in {
    formatter.x86_64-linux = inputs.nixpkgs.legacyPackages.x86_64-linux.alejandra;

    nixosConfigurations = {
      nixos = inputs.nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./nixos/configuration.nix
          inputs.grub2-themes.nixosModules.default
          inputs.sops-nix.nixosModules.sops
        ];
      };
    };

    homeConfigurations = {
      grig-gn = mkHomeConfig "grig-gn";
      grig-iv = mkHomeConfig "grig-iv";
      grig-wsl = mkHomeConfig "grig-wsl";
    };
  };
}
