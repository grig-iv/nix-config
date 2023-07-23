{ config, pkgs, ... }:

{
  imports = [
    ./shared
    ./modules
  ];

  home.packages = with pkgs; [
    alacritty 
    telegram-desktop  
    discord
    tor-browser-bundle-bin
    firefox
    spotify
    tor
    keepass
    obs-studio
    mpv-unwrapped

    virt-manager libvirt

    wireguard-tools
    neovim
    htop
    git
    wget
    curl
    unzip
    tldr  
    vifm 
    chezmoi age

    gnome-extension-manager
    gnomeExtensions.blur-my-shell
    gnomeExtensions.vitals
    gnomeExtensions.openweather
    gnomeExtensions.removable-drive-menu
    gnomeExtensions.user-themes
  ];

  dconf = {
    enable = true;
    settings = {
      "org/gnome/shell" = {
        favorite-apps = [
          "org.telegram.desktop.desktop"
          "discord.desktop"
          "firefox.deskto"
          "Alacritty.deskt"
        ];

        disable-user-extensions = false;
        enabled-extensions = [
          "blur-my-shell@aunetx"
          "Vitals@CoreCoding.com"
          "openweather-extension@jenslody.de"
          "drive-menu@gnome-shell-extensions.gcampax.github.com"

          "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
          "launch-new-instance@gnome-shell-extensions.gcampax.github.com"
          "native-window-placement@gnome-shell-extensions.gcampax.github.com"
          "user-theme@gnome-shell-extensions.gcampax.github.com"
        ];
      };

      "/org/gnome/shell/extensions/blur-my-shell" = {
        noise-amount = "0.80"; 
        noise-lightness = "0.80";
      };

      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };

      "/org/gnome/mutter" = {
        edge-tiling = true; 
      };
    };
  };

environment.variables.EDITOR

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
    config = {
      core = {
        "safe.directory" = "/etc/nixos";
      };
    };
  };

  services.redshift = {
    enable = true;
    temperature.night = 3000;
    temperature.day = 6500;
    latitude = 59.951828;
    longitude = 30.342980;
  };

  programs.home-manager.enable = true;
  home.username = "grig-gn";
  home.homeDirectory = "/home/grig-gn";
  home.stateVersion = "23.05"; # lock. do not change

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = (_: true);  # Workaround for https://github.com/nix-community/home-manager/issues/2942
  };
}

