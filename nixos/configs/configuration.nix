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
    ./steam.nix
    ./picom.nix
    ./fonts.nix
    ./keyboard
    ./nix.nix
    ./hardware-configuration.nix
    ./bootloader.nix
    ./nvidia.nix
    ./wm.nix
    ./audio.nix
    ./sudo.nix
    #    ./vm.nix
    ./sops.nix
    #    ./wireguard.nix
  ];

  networking.firewall.enable = false;

  virtualisation.docker.enable = true;

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
    docker-compose
  ];

  # USB mount
  services.udisks2.enable = true;
  boot.supportedFilesystems = ["ntfs"];
}
