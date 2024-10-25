{...}: {
  imports = [
    ./modules
    ./configs/wsl.nix
    ./configs/nix.nix
    ./configs/shared/shell.nix # remove
    ./configs/fish.nix
    ./configs/neovim.nix
    ./configs/notes.nix
    ./configs/ssh
    ./configs/tmux.nix
    ./configs/yazi
    ./configs/git.nix
    ./configs/lazygit.nix
    ./configs/skim.nix
    ./configs/eza.nix
    ./configs/bat.nix
    ./configs/qmk.nix
  ];

  home = {
    username = "grig";
    homeDirectory = "/home/grig";
    stateVersion = "23.05";
  };
  my.hostInfo. windowsUserPath = "/mnt/c/Users/grig/";

}
