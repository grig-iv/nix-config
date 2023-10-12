{
  pkgs,
  lib,
  ...
}:
with lib; {
  imports = [./development/lua.nix];

  programs = {
    neovim = {
      enable = true;
      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
    #vscode.extensions = [pkgs.vscode-marketplace.asvetliakov.vscode-neovim];
  };

  home = {
    packages = with pkgs; [
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

    sessionVariables = {
      EDITOR = mkDefault "nvim";
      NVIMCONF = mkDefault "$CONFIG/nvim";
      EXTMIND = mkDefault "$HOME/extended-mind";
    };

    shellAliases = {
      n = ''cd $NVIMCONF & $EDITOR $(${pkgs.fd}/bin/fd -t f | ${pkgs.skim}/bin/sk --preview "${pkgs.bat}/bin/bat --color=always --style=numbers {}" )'';
    };
  };
}
