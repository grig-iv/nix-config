update-unstable:
    nix flake lock --update-input nixpkgs-unstable

update-pkgs:
    nix flake lock --update-input nixpkgs
