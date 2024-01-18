{...}: {
  imports = [
    ./configs/shared/wsl.nix
    ./configs/notes.nix
    ./configs/ssh.nix
    ./configs/sops.nix

    ./configs/development/rust.nix
  ];
}
