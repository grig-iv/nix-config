{...}: {
  imports = [
    ./configs/shared/wsl.nix
    ./configs/development/rust.nix
    ./configs/notes.nix
  ];

  # FIXME
  home = {
    username = "grig-wsl";
    homeDirectory = "/home/grig-wsl";
  };
}
