{ config, pkgs, ... }:

{
  imports = [
    ./apps
  ];

  home.packages = with pkgs; [
    alacritty 
    telegram-desktop  
    discord
    tor-browser-bundle-bin
    firefox
    tor
    keepass
    obs-studio
    mpv-unwrapped

    virt-manager libvirt

    rofi
    dunst  
    xclip
    feh
    maim
    sxiv
    haskellPackages.xmobar
    picom-jonaburg
    pulsemixer
    ueberzugpp  # terminal image viewer
    evtest
    neofetch

    gnome-extension-manager
    gnomeExtensions.blur-my-shell
    gnomeExtensions.openweather
    gnomeExtensions.removable-drive-menu


    qmk  
    wireguard-tools
    neovim
    htop
    git
    wget
    curl
    unzip
    tldr  
    udiskie
    udisks2
    vifm 
    chezmoi age
  ];

  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "firefox";
    TERMINAL = "alacritty";
    CONFIG = "$HOME/.config";
    CHEZMOI = "$HOME/.local/share/chezmoi";
  };

  programs.git = {
    enable = true;
    userName = "grig-iv";
    userEmail = "abstractgrig@gmail.com";
  };

  services.redshift = {
    enable = true;
    temperature.night = 3000;
    latitude = 59.951828;
    longitude = 30.342980;
  };

  services.unclutter = {
    enable = true;
    timeout = 5;
  };

  grig = {
      programs = {
          fish.enable = true;
      };
  };

  programs.home-manager.enable = true;
  home.username = "grig-xm";
  home.homeDirectory = "/home/grig-xm";
  home.stateVersion = "23.05"; # lock. do not change

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = (_: true);  # Workaround for https://github.com/nix-community/home-manager/issues/2942
  };
}

