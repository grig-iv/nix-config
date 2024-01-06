{pkgs, ...}: let
  mkUser = user: name: {
    isNormalUser = true;
    initialPassword = user;
    description = name;
    shell = pkgs.fish;
    extraGroups = ["wheel" "networkmanager" "docker"];
  };
in {
  imports = [
    ./configs/nix.nix
    ./configs/sops.nix
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
  users.users = {
    "grig-iv" = mkUser "grig-iv" "Grig IV";
    "grig-gn" = mkUser "grig-gn" "Grig GN";
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
}
