{...}: {
  imports = [
    ./configs/shared/wsl.nix
    ./configs/development/rust.nix
    ./configs/notes.nix
    ./modules/scoop.nix
  ];

  # FIXME
  home = {
    username = "grig-wsl";
    homeDirectory = "/home/grig-wsl";
  };
}
