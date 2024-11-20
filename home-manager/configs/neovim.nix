{
  config,
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
    ripgrep.enable = true;
  };

  my.shell.bookmarks = [
    {
      path = config.home.sessionVariables.NVIMCONF;
      binding = "n";
    }
  ];

  home = {
    packages = with pkgs; [
      git
      wget
      curl
      unzip
      tree-sitter
      fd
      jq
      nodejs_20
      nodePackages.cspell
    ];

    sessionVariables = {
      EDITOR = mkDefault "nvim";
      NVIMCONF = mkDefault "~/.config/nvim";
      EXTMIND = mkDefault "$HOME/extended-mind";
    };

    shellAliases = {
      n = "jump -r $NVIMCONF";
    };
  };
}
