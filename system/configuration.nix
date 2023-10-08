{pkgs, ...}: let
  mkUser = user: name: {
    isNormalUser = true;
    initialPassword = user;
    description = name;
    shell = pkgs.fish;
    extraGroups = ["wheel" "networkmanager" "libvirtd" "nixos"];
  };
in {
  imports = [
    ./hardware-configuration.nix
    ./bootloader.nix
    ./nvidia.nix
    ./audio.nix
    ./gnome.nix
    ./sudo.nix
    ./vm.nix
    ./sops.nix
    ./wireguard.nix
  ];

  # keep the last 10 system configurations.
  nix.gc.automatic = true;
  nix.gc.options = "--delete-older-than 5d";

  # Networking
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Internationalisation
  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "en_US.UTF-8";

  # Xserver
  services.xserver = {
    enable = true;
    autorun = true;
    displayManager.startx.enable = true;

    windowManager = {
      xmonad.enable = true;
      awesome.enable = true;
    };

    layout = "us,ru";
    xkbOptions = "grp:alt_shift_toggle";
    /*
      extraLayouts.ru-grig = {
      description = "Grig RU layout";
      languages = ["ru"];
      symbolsFile = ./layout-ru.xkb;
    };
    */
  };

  # fix windows clock async
  time.hardwareClockInLocalTime = true;

  # groups
  users.groups.nixos = {};
  programs.fish.enable = true;
  users.users."grig-iv" = mkUser "grig-iv" "Grig IV";
  users.users."grig-gn" = mkUser "grig-gn" "Grig GN";

  # Fonts
  fonts.fonts = with pkgs; [
    (nerdfonts.override {
      fonts = [
        "JetBrainsMono"
        "Mononoki"
      ];
    })
    font-awesome
    roboto-mono
  ];

  # System packages
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    home-manager
    neovim
    git
    wget
    curl
    unzip
    sops
    age
  ];

  # USB mount
  services.udisks2.enable = true;
  boot.supportedFilesystems = ["ntfs"];

  # misc
  nix.package = pkgs.nixFlakes;
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    allowed-users = ["grig-iv" "grig-gn" "grig-xm"];
    auto-optimise-store = true;
  };

  hardware.keyboard.qmk.enable = true;
  documentation.man.enable = false;

  system.stateVersion = "23.05";
}
