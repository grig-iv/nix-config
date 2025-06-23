{inputs, ...}: let
  pkgs = import inputs.nixpkgs {
    system = "x86_64-linux";
    config.allowUnfree = true;
    overlays = with inputs; [
      nur.overlay
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

    "grig@tha" = inputs.home-manager.lib.homeManagerConfiguration {
      inherit pkgs extraSpecialArgs;
      modules = [(./. + "/grig@tha.nix")];
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
