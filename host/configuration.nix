{ config, pkgs, ... }:

{
  imports = [ ./hardware-configuration.nix ];

  # Bootloader.
  boot.loader = {
    timeout = 10;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot";
    };
    grub = {
      enable = true;
      device = "nodev";
      configurationLimit = 5;
      efiSupport = true;
    };
    grub2-theme = {
      enable = true;
      theme = "stylish";
      footer = true;
      screen = "2k";
    };
  };

  # keep the last 10 system configurations.
  nix.gc.automatic = true;
  nix.gc.options = "--delete-older-than 30d";

  # Networking
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Internationalisation 
  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ru_RU.UTF-8";
    LC_IDENTIFICATION = "ru_RU.UTF-8";
    LC_MEASUREMENT = "ru_RU.UTF-8";
    LC_MONETARY = "ru_RU.UTF-8";
    LC_NAME = "ru_RU.UTF-8";
    LC_NUMERIC = "ru_RU.UTF-8";
    LC_PAPER = "ru_RU.UTF-8";
    LC_TELEPHONE = "ru_RU.UTF-8";
    LC_TIME = "ru_RU.UTF-8";
  };


  # Xserver
  services.xserver = {
    enable = true;
    autorun = true;
    layout = "us";

    displayManager.gdm.enable = true;
    desktopManager.gnome.enable = true;

    windowManager.xmonad = {
      enable = true;
      enableContribAndExtras = true;
      config = builtins.readFile ../dot_config/xmonad/xmonad.hs;
    };
  };

  environment.gnome.excludePackages = (with pkgs; [
    gnome-photos
    gnome-tour
  ]) ++ (with pkgs.gnome; [
    cheese 
    gnome-music
    gnome-terminal
    gedit 
    epiphany 
    geary 
    evince 
    gnome-characters
    totem 
    tali
    iagno
    hitori
    atomix 
  ]);


  # fix windows clock async
  time.hardwareClockInLocalTime = true;


  # Users
  programs.fish.enable = true;
  users.users."grig-xm" = {
    isNormalUser = true;
    initialPassword = "grig-xm";
    description = "xmonad | code | keyboard";
    shell = pkgs.fish;
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
  };
  users.users."grig-gn" = {
    isNormalUser = true;
    initialPassword = "grig-gn";
    description = "gnome | chill | mouse";
    shell = pkgs.fish;
    extraGroups = [ "networkmanager" "wheel" "libvirtd" ];
  };

  # Fonts
  fonts.fonts = with pkgs; [
    (nerdfonts.override { fonts = [ "JetBrainsMono" ]; })
    font-awesome
  ];


  # System packages
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  environment.systemPackages = with pkgs; [
    neovim
    git
    wget
    curl
    unzip
    xclip
    udiskie
    gcc
  ];


  # USB mount
  services.udisks2.enable = true;
  boot.supportedFilesystems = [ "ntfs" ];

  # audio
  hardware.pulseaudio = {
    enable = true;
    extraConfig = "unload-module module-suspend-on-idle";
  };


  # misc
  nix.settings.allowed-users = [ "grig-xm" "grig-gn"  ];
  hardware.keyboard.qmk.enable = true;
  hardware.opengl.enable = true; 
  hardware.opengl.driSupport = true;


  # something with virt-manager
  virtualisation.libvirtd.enable = true;
  programs.dconf.enable = true;


  system.stateVersion = "23.05";
}
