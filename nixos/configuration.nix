{pkgs, ...}: let
  mkUser = user: name: {
    isNormalUser = true;
    initialPassword = user;
    description = name;
    shell = pkgs.fish;
    extraGroups = ["wheel" "networkmanager"];
  };
in {
  imports = [
    ./keyboard
    ./nix.nix
    ./hardware-configuration.nix
    ./bootloader.nix
    ./nvidia-close.nix
    ./wm.nix
    ./audio.nix
    ./sudo.nix
    ./fonts.nix
    #    ./vm.nix
    ./sops.nix
    #    ./wireguard.nix
  ];

  networking.firewall.enable = false;

  # Networking
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Internationalisation
  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "en_US.UTF-8";

  # fix windows clock async
  time.hardwareClockInLocalTime = true;

  programs.fish.enable = true;
  users.users."grig-iv" = mkUser "grig-iv" "Grig IV";
  users.users."grig-gn" = mkUser "grig-gn" "Grig GN";

  # System packages
  environment.systemPackages = with pkgs; [
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
}
