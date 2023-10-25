{inputs, ...}: let
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
        ./${userName}.nix
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
  flake.homeConfigurations = {
    grig-gn = mkHomeConfig "grig-gn";
    grig-iv = mkHomeConfig "grig-iv";
    grig-wsl = mkHomeConfig "grig-wsl";
  };
}
