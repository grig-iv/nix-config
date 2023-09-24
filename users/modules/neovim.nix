{pkgs, ...}: {
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  home.packages = with pkgs; [
    git
    wget
    curl
    unzip
    tree-sitter
    gcc
    ripgrep
    fd
    nodejs_20
    gnumake

    #ltex-ls
  ];
}
