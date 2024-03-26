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
    ./configs/dictd.nix
    ./configs/vm.nix
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

  services.syncthing.user = user;
  users.users = {
    "${user}" = {
      isNormalUser = true;
      initialPassword = user;
      description = "Grig";
      shell = pkgs.fish;
      extraGroups = [
        "wheel"
        "networkmanager"
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

  system.stateVersion = "23.05";
}
