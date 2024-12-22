{
  pkgs,
  unstable,
  ...
}: {
  imports = [
    ./modules
    ./configs/wsl.nix
    ./configs/fish.nix
    ./configs/neovim.nix
    ./configs/ssh
    # ./configs/tmux.nix
    # ./configs/yazi
    ./configs/git.nix
  ];

  home = {
    username = "grig";
    homeDirectory = "/home/grig";
    stateVersion = "23.05";
    packages = with pkgs; [
      bat
      bc
      bottom
      curl
      calcurse
      diskonaut
      just
      unstable.helix
      unzip
      stow
      tldr
      tree
      lazygit
      lf
      wget
      qmk
      zip

      unstable.yazi
      glow

      tmux
      tmuxp

      # lsp & formaters
      marksman # makrdown
      taplo # toml
      vscode-langservers-extracted # html/css/json
      yaml-language-server # yaml

      nil
      alejandra

      lua-language-server
      stylua

      go
      unstable.gopls
      gore
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

  manual = {
    manpages.enable = false;
  };

  systemd.user.startServices = "sd-switch";
}
