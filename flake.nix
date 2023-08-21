{
  description = "My nixos config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    grub2-themes.url = "github:vinceliuice/grub2-themes";
    nix-colors.url = "github:misterio77/nix-colors";
    neovim-grig.url = "github:grig-iv/neovim-flake";
  };

  outputs = {
    self,
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    neovim-grig,
    ...
  } @ inputs:
    with nixpkgs.lib; let
      #    nvim = neovim-grig.packages.x86_64-linux.nvim;
      mkHomeConfig = userName:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = {
            inherit (self) inputs outputs;
            inherit nixpkgs-unstable;
          };
          modules = [
            ./users/${userName}.nix
            {
              #            home.packages = [nvim];

              home.sessionVariables = {
                EDITOR = mkDefault "nvim";
                CONFIG = mkDefault "$HOME/.config";
                CHEZMOI = mkDefault "$HOME/.local/share/chezmoi";
                NIXCONF = mkDefault "/etc/nixos";
                NVIMCONF = mkDefault "$CONFIG/neovim-flake";
              };

              xdg.enable = true;
              programs.home-manager.enable = true;
              home.username = userName;
              home.homeDirectory = "/home/${userName}";
              home.stateVersion = "23.05"; # lock. do not change

              nixpkgs.config = {
                allowUnfree = true;
                allowUnfreePredicate = _: true; # Workaround for https://github.com/nix-community/home-manager/issues/2942
              };
            }
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
        grig-gn = mkHomeConfig "grig-gn";
        grig-xm = mkHomeConfig "grig-xm";
        grig-aw = mkHomeConfig "grig-aw";
        grig-wsl = mkHomeConfig "grig-wsl";
      };
    };
}
