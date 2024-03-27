{pkgs, ...}: {
  imports = [
    ./modules
    ./configs/hardware-configuration.nix
    ./configs/user.nix
    ./configs/networking.nix
    ./configs/nix.nix
    ./configs/home-manager.nix
    ./configs/steam.nix
    ./configs/picom.nix
    ./configs/fonts.nix
    ./configs/keyboard
    ./configs/bootloader.nix
    ./configs/nvidia.nix
    ./configs/xserver.nix
    ./configs/audio.nix
    ./configs/sudo.nix
    ./configs/wireguard.nix
    ./configs/syncthing.nix
    ./configs/shadowsocks.nix
    ./configs/docker.nix
    ./configs/dictd.nix
    ./configs/vm.nix
  ];

  my = {
    user = "grig-iv";
    host = "xtal";
  };

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

  system.stateVersion = "23.05";
}
