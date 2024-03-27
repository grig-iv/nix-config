{...}: {
  imports = [
    ./modules

    ./configs/wsl.nix
    ./configs/nix.nix
    ./configs/shared/shell.nix # remove
    ./configs/fish.nix
    ./configs/neovim.nix
    ./configs/notes.nix
    ./configs/ssh.nix
    ./configs/tmux.nix
    ./configs/yazi
    ./configs/git.nix
    ./configs/lazygit.nix
    ./configs/skim.nix
    ./configs/eza.nix
    ./configs/bat.nix
  ];

  home = {
    username = "grig";
    homeDirectory = "/home/grig";
  };

  system.stateVersion = "23.05";
}
