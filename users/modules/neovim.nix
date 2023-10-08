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
    n = ''cd $NVIMCONF & $EDITOR $(${pkgs.fd}/bin/fd -t f | ${pkgs.skim}/bin/sk --preview "${pkgs.bat}/bin/bat --color=always --style=numbers {}" )'';
    m = "cd ~/extended-mind & e index.norg";
  };
}
