{
  config,
  pkgs,
  lib,
  inputs,
  ...
} @ args: {
  imports = [
    inputs.nix-colors.homeManagerModules.default

    ./modules/my.nix
    ./modules/git.nix
    ./modules/fish.nix
    ./modules/alacritty.nix
    ./modules/redshift.nix
    ./modules/rofi.nix
    ./modules/unclutter.nix
    ./modules/awesome.nix
    ./modules/dunst.nix
  ];

  home.packages = with pkgs; [
    alacritty
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
    picom-jonaburg
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
    BROWSER = "firefox";
    TERMINAL = "alacritty";
  };

  programs.autorandr.enable = true;
}
