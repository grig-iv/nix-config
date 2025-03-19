{
  pkgs,
  unstable,
  ...
}: {
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
    .././configs/cuda.nix
    .././configs/xserver.nix
    .././configs/audio.nix
    .././configs/sudo.nix
    .././configs/syncthing.nix
    .././configs/docker.nix
    .././configs/printing.nix
    .././configs/proxychains.nix
    .././configs/vm.nix
    .././configs/wifi-adapter.nix
  ];

  my = {
    user = "grig";
    host = "xtal";
  };

  services.yggdrasil = {
    enable = true;
    package = unstable.yggdrasil;
    persistentKeys = true;
    settings = {
      Peers = [
        "tls://38.180.77.225:5051?password=MJvO5Nxuor6UqmjbNYSOwA1Fmrt3PVfR"
        "tls://37.1.221.231:5051?password=0r48BfdAkckJ9c40L7p7gA0ETxXj6kBM"
      ];
    };
  };

  networking.firewall = {
    allowedTCPPortRanges = [
      {
        from = 50000;
        to = 50500;
      }
    ];
  };

  services = {
    open-webui.enable = true;
    ollama.enable = true;
  };

  services = {
    displayManager.defaultSession = "none+qtile";
    xserver.displayManager.session = [
      {
        manage = "window";
        name = "dwm";
        start = "exec $HOME/.xsession";
      }
      {
        manage = "window";
        name = "mind-shift";
        start = "exec $HOME/.xsession";
      }
      {
        manage = "window";
        name = "qtile";
        start = "exec $HOME/.xsession";
      }
    ];
    v2raya.enable = true;
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
    unstable.shadowsocks-rust
    unstable.yggdrasil
  ];

  # USB mount
  services.udisks2.enable = true;
  boot.supportedFilesystems = ["ntfs"];

  system.stateVersion = "24.05";
}
