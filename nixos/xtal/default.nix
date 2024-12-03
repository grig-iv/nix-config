{pkgs, ...}: {
  imports = [
    ./disko.nix
    ./hardware-configuration.nix
    # ./bootloader.nix ## remove if woked without
    .././modules
    .././configs/user.nix
    .././configs/nix.nix
    .././configs/home-manager.nix
    .././configs/steam.nix
    .././configs/fonts.nix
    .././configs/keyboard
    .././configs/nvidia.nix
    .././configs/xserver.nix
    .././configs/audio.nix
    .././configs/sudo.nix
    .././configs/syncthing.nix
    .././configs/shadowsocks.nix
    .././configs/docker.nix
    .././configs/printing.nix
    .././configs/proxychains.nix
    .././configs/wifi-adapter.nix
  ];

  my = {
    user = "grig";
    host = "xtal";
  };

  services = {
    displayManager.defaultSession = "none+mind-shift";
    xserver.displayManager.session = [
      {
        manage = "window";
        name = "dwm";
        start = "exec $HOME/.xsession";
      }
      {
        manage = "window";
        name = "mind-shift";
        start = "exec $OME/.xsession";
      }
    ];
  };

  boot.loader = {
    timeout = 10;
    efi = {
      canTouchEfiVariables = true;
      efiSysMountPoint = "/boot/efi";
    };
    grub = {
      enable = true;
      efiSupport = true;
      # efiInstallAsRemovable = true;
      device = "nodev";
      useOSProber = true;
    };
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
    usbutils
  ];

  # USB mount
  services.udisks2.enable = true;
  boot.supportedFilesystems = ["ntfs"];

  system.stateVersion = "24.05";
}
