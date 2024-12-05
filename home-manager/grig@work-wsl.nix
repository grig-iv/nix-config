{pkgs, ...}: {
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
    ./configs/skim.nix
    ./configs/bat.nix
    ./configs/qmk.nix
    ./configs/development/go.nix
  ];

  home = {
    username = "grig";
    homeDirectory = "/home/grig";
    stateVersion = "23.05";
    packages = with pkgs; [
      stow
      lazygit
      lf
      helix
    ];
  };

  my = {
    hostInfo.windowsUserPath = "/mnt/c/Users/grig/";
    repositories = [
      {
        url = "git@github.com:grig-iv/nvim.git";
        path = "$HOME/.config/nvim";
      }
      {
        url = "git@github.com:grig-iv/dotfiles.git";
        path = "$HOME/.config/dotfiles";
      }
    ];
  };
}
