{
  pkgs,
  inputs,
  unstable,
  ...
}: let
  user = "grig-iv";
in {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager = {
        sharedModules = [inputs.sops-nix.homeManagerModules.sops];
        extraSpecialArgs = {inherit inputs unstable;};
        useGlobalPkgs = true;
        useUserPackages = true;
        users.grig-iv = import (../home-manager + "/grig@xtal.nix");
      };
    }

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
      hashedPassword = "$y$j9T$0.SupuqUwYCulmsOKZ9l9.$W0GA7D8PRmGGxE/H2nHDzfQtTmbOO5dUWJNitadvY3A";
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
}
