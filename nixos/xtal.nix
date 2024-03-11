{
  pkgs,
  inputs,
  ...
}: let
  user = "grig-iv";
in {
  imports = [
    ./configs/nix.nix
    ./configs/steam.nix
    ./configs/picom.nix
    ./configs/fonts.nix
    ./configs/keyboard
    ./configs/hardware-configuration.nix
    ./configs/bootloader.nix
    ./configs/nvidia.nix
    ./configs/xserver.nix
    ./configs/audio.nix
    ./configs/sudo.nix
    ./configs/wireguard.nix
    ./configs/syncthing.nix
    ./configs/shadowsocks.nix
    ./configs/docker.nix
    #    ./configs/vm.nix
  ];

  networking = {
    hostName = "xtal";
    networkmanager.enable = true;
    firewall.enable = false;
  };

  # Internationalisation
  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "en_US.UTF-8";

  # fix windows clock async
  time.hardwareClockInLocalTime = true;

  programs.fish.enable = true;

  services.syncthing.user = "grig-iv";
  users.users = {
    "grig-iv" = {
      isNormalUser = true;
      initialPassword = user;
      description = "Grig";
      shell = pkgs.fish;
      extraGroups = [
        "wheel"
        "networkmanager"
        "docker"
      ];
    };
  };

  # System packages
  environment.systemPackages = with pkgs; [
    neovim
    git
    wget
    curl
    unzip
  ];

  # USB mount
  services.udisks2.enable = true;
  boot.supportedFilesystems = ["ntfs"];

  # autoUpgrade
  system.autoUpgrade = {
    enable = true;
    flake = inputs.self.outPath;
    flags = [
      "--update-input"
      "nixpkgs"
      "-L" # print build logs
    ];
    dates = "10:00";
    randomizedDelaySec = "45min";
  };
}
