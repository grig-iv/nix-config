{
  config,
  pkgs,
  lib,
  ...
}: let
  ghcPkgs =
    if config.xsession.windowManager.xmonad.enable
    then
      pkgs.haskellPackages.ghcWithPackages (hpkgs: [
        hpkgs.xmobar
        hpkgs.xmonad
        hpkgs.xmonad-contrib
      ])
    else pkgs.ghc;
in {
  home = {
    packages = with pkgs; [
      haskell-language-server
      ghcPkgs
    ];
  };

  programs.vscode.haskell = {
    enable = true;
    hie.enable = true;
    hie.executablePath = lib.getExe pkgs.haskell-language-server;
  };
}
