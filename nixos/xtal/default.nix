{pkgs, ...}: {
  imports = [
    ./disko.nix
    ./hardware-configuration.nix
    ./bootloader.nix
    .././modules
    .././configs/user.nix
    .././configs/nix.nix
    .././configs/home-manager.nix
    .././configs/steam.nix
    .././configs/picom.nix
    .././configs/fonts.nix
    .././configs/keyboard
    .././configs/nvidia.nix
    .././configs/xserver.nix
    .././configs/audio.nix
    .././configs/sudo.nix
    .././configs/syncthing.nix
    .././configs/shadowsocks.nix
    .././configs/docker.nix
  ];

  my = {
    user = "grig";
    host = "xtal";
  };

  networking.firewall.enable = true;

  boot.tmp.cleanOnBoot = true;

  # Internationalisation
  time.timeZone = "Europe/Moscow";
  i18n.defaultLocale = "en_US.UTF-8";

  # fix windows clock async
  time.hardwareClockInLocalTime = true;

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

  system.stateVersion = "24.05";
}
