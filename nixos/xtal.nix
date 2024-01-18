{
  pkgs,
  config,
  ...
}: let
  user = "grig-iv";
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
    ./configs/syncthing.nix
    ./configs/shadowsocks.nix
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
    "grig-iv" = {
      isNormalUser = true;
      initialPassword = user;
      description = "Grig IV";
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

  services.syncthing = {
    inherit user;
    settings = {
      devices = {
        "phone".id = "WQ2IBG5-LHTOBE5-QAKLUKH-NXKZZZX-SMIMQ7T-2HLUXTM-FNVSH4Z-Y3QTVAD";
        "work-wsl".id = "XWUW5YU-B2MTUK7-33TJ4TM-ZKNMUT3-RAQKWBT-SXBDDUF-4I4EGIZ-OBIXPQP";
        "tha-wsl".id = "HV35JBN-LZLIZWK-KSZTMLD-3J25IYS-DYDYIAN-B3A7LNE-EQIPAJH-AQMVPQR";
      };
      folders = {
        "Extended Mind" = {
          id = "tcgvs-gd77k";
          path = "/home/${user}/Extended Mind";
          devices = ["phone" "work-wsl"];
        };
        "Books" = {
          id = "ztshj-sh3ra";
          path = "/home/${user}/Books";
          devices = ["phone"];
        };
        "Camera" = {
          id = "7pgoy-oxxrb";
          path = "/home/${user}/Camera";
          devices = ["phone"];
        };
        "Interlinked Cells" = {
          id = "rfkva-mxs67";
          path = "/home/${user}/Interlinked Cells";
          devices = ["phone" "tha-wsl"];
        };
        "Quick Share" = {
          id = "mudfh-6fzjh";
          path = "/home/${user}/Quick Share";
          devices = ["phone"];
        };
      };
    };
  };
}
