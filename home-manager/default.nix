{inputs, ...}: let
  pkgs = import inputs.nixpkgs {
    system = "x86_64-linux";
    config.allowUnfree = true;
    overlays = with inputs; [
      nur.overlay
      tidal-cycles.overlays.tidal
      nix-vscode-extensions.overlays.default
      ollama.overlays.default
      rust-overlay.overlays.default
      yazi.overlays.default
      (import ./../overlays)
    ];
  };

  extraSpecialArgs = {
    inherit (inputs.self) inputs outputs;
    unstable = import inputs.nixpkgs-unstable {
      system = "x86_64-linux";
      config.allowUnfree = true;
    };
  };
in {
  flake.homeConfigurations = {
    "grig@xtal" = inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs extraSpecialArgs;
      modules = [(./. + "/grig@xtal.nix")];
    };

    "grig@tha-wsl" = inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs extraSpecialArgs;
      modules = [(./. + "/grig@tha-wsl.nix")];
    };

    "grig@work-wsl" = inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs extraSpecialArgs;
      modules = [(./. + "/grig@work-wsl.nix")];
    };
  };
}
