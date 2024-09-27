{pkgs, ...}: {
  imports = [
    ./disko.nix
    ./hardware-configuration.nix
    #    ./bootloader.nix ## remove if woked without
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
  ];

  my = {
    user = "grig";
    host = "xtal";
  };

  services = {
    displayManager.defaultSession = "dwm";
    xserver.displayManager = {
      session = [
        {
          manage = "desktop";
          name = "dwm";
          start = ''exec $HOME/.xsession'';
        }
      ];
    };
  };

  boot.loader = {
    systemd-boot.enable = true;
    efi.canTouchEfiVariables = true;
    timeout = 10;
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
