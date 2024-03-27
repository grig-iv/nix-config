{inputs, ...}: let
  pkgs = import inputs.nixpkgs {
    system = "x86_64-linux";
    config = {
      allowUnfree = true;
      permittedInsecurePackages = [
        "electron-25.9.0"
      ];
    };
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

  specialArgs = {
    inherit (inputs.self) inputs outputs;
    unstable = import inputs.nixpkgs-unstable {
      system = "x86_64-linux";
      config.allowUnfree = true;
    };
  };
in {
  flake.nixosConfigurations = {
    xtal = inputs.nixpkgs.lib.nixosSystem {
      inherit pkgs specialArgs;
      system = "x86_64-linux";
      modules = [./xtal.nix];
    };
    tha-wsl = inputs.nixpkgs.lib.nixosSystem {
      inherit pkgs specialArgs;
      system = "x86_64-linux";
      modules = [./tha-wsl.nix];
    };
    work-wsl = inputs.nixpkgs.lib.nixosSystem {
      inherit pkgs specialArgs;
      system = "x86_64-linux";
      modules = [./work-wsl.nix];
    };
    vps-nl = inputs.nixpkgs.lib.nixosSystem {
      inherit pkgs specialArgs;
      system = "x86_64-linux";
      modules = [
        "${pkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
        ./vps-nl.nix
      ];
    };
  };
}
