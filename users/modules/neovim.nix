{
  pkgs,
  lib,
  ...
}:
with lib; {
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

  home.sessionVariables = {
    EDITOR = mkDefault "nvim";
    NVIMCONF = mkDefault "$CONFIG/nvim";
    EXTMIND = mkDefault "$HOME/extended-mind";
  };

  home.shellAliases = {
    n = "cd $NVIMCONF & e";
    m = "cd ~/extended-mind & e index.norg";
  };
}
