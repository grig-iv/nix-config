{
  description = "My nixos config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/release-25.05";

    nur.url = "github:nix-community/NUR";
    flake-parts.url = "github:hercules-ci/flake-parts";
    sops-nix.url = "github:Mic92/sops-nix";
    nixos-wsl.url = "github:nix-community/NixOS-WSL";
    disko.url = "github:nix-community/disko";

    grig-dwm.url = "github:grig-iv/dwm";
    grig-gost.url = "github:grig-iv/gost";
    grig-plato.url = "github:grig-iv/plato";

    grub2-themes.url = "github:vinceliuice/grub2-themes";
    tidal-cycles.url = "github:mitchmindtree/tidalcycles.nix";
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    ollama.url = "github:havaker/ollama-nix";
    rust-overlay.url = "github:oxalica/rust-overlay";
    yazi.url = "github:sxyazi/yazi";
  };

  outputs = inputs:
    inputs.flake-parts.lib.mkFlake {inherit inputs;} {
      imports = [
        ./home-manager
      ];
      systems = ["x86_64-linux"];
      perSystem = {pkgs, ...}: {
        formatter = pkgs.alejandra;
      };
    };
}
