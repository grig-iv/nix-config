{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./bootloader.nix
    ./nvidia.nix
    ./audio.nix
    ./gnome.nix
    ./sudo.nix
    ./vm.nix
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
    layout = "us";

    windowManager.xmonad.enable = true;
  };

  # fix windows clock async
  time.hardwareClockInLocalTime = true;

  # groups
  users.groups.nixos = {};
  programs.fish.enable = true;
  users.users."grig-xm" = {
    isNormalUser = true;
    initialPassword = "grig-xm";
    description = "Grig XM";
    shell = pkgs.fish;
    extraGroups = ["wheel" "networkmanager" "libvirtd" "nixos"];
  };
  users.users."grig-gn" = {
    isNormalUser = true;
    initialPassword = "grig-gn";
    description = "Grig GN";
    shell = pkgs.fish;
    extraGroups = ["wheel" "networkmanager" "nixos"];
  };

  # Fonts
  fonts.fonts = with pkgs; [
    (nerdfonts.override {
      fonts = [
        "JetBrainsMono"
        "Mononoki"
      ];
    })
    font-awesome
  ];

  # System packages
  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    neovim
    git
    wget
    curl
    unzip
    gcc # need for nvim packer
  ];

  # USB mount
  services.udisks2.enable = true;
  boot.supportedFilesystems = ["ntfs"];

  # misc
  nix.package = pkgs.nixFlakes;
  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    allowed-users = ["grig-xm" "grig-gn"];
  };

  hardware.keyboard.qmk.enable = true;
  documentation.man.enable = false;

  system.stateVersion = "23.05";
}
