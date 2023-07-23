{
  config,
  pkgs,
  lib,
  inputs,
  ...
} @ args: {
  imports = [
    inputs.nix-colors.homeManagerModules.default

    ./modules
    ./imports/git.nix
    ./imports/fish.nix
    ./imports/alacritty.nix
    ./imports/redshift.nix
    ./imports/rofi.nix
    ./imports/unclutter.nix
    ./imports/xmobar.nix
    ./imports/xmonad.nix
    ./imports/dunst.nix
    ./imports/picom.nix
  ];

  home.packages = with pkgs; [
    firefox
    obs-studio
    telegram-desktop
    mattermost-desktop
    element-desktop
    qbittorrent
    inkscape


    dunst
    xclip
    feh
    maim
    sxiv
    pulsemixer
    evtest
    neofetch
    cbonsai

    qmk
    wireguard-tools
    htop
    git
    wget
    curl
    unzip
    tldr
    udiskie
    udisks2
    vifm
    ueberzugpp # terminal image viewer
    chezmoi
    age

    # dev
    nodejs_20
  ];

  colorScheme = inputs.nix-colors.colorSchemes.dracula;

  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "firefox";
    TERMINAL = "alacritty";
    CONFIG = "$HOME/.config";
    CHEZMOI = "$HOME/.local/share/chezmoi";
  };

  programs.autorandr.enable = true;

  xdg.enable = true;
  programs.home-manager.enable = true;
  home.username = "grig-xm";
  home.homeDirectory = "/home/grig-xm";
  home.stateVersion = "23.05"; # lock. do not change

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = _: true; # Workaround for https://github.com/nix-community/home-manager/issues/2942
  };
}
