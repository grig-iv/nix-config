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
      withNodeJs = true;
      withPython3 = true;
      extraPackages = with pkgs; [
        gcc
      ];
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
      ripgrep
      fd
      nodejs_20
      nodePackages.cspell
    ];

    sessionVariables = {
      EDITOR = mkDefault "nvim";
      NVIMCONF = mkDefault "$CONFIG/nvim";
      EXTMIND = mkDefault "$HOME/extended-mind";
    };

    shellAliases = {
      gn = "cd $NVIMCONF";
      n = ''cd $NVIMCONF & $EDITOR $(${pkgs.fd}/bin/fd -t f | ${pkgs.skim}/bin/sk --preview "${pkgs.bat}/bin/bat --color=always --style=numbers {}" )'';
    };
  };
}
