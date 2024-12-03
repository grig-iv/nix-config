{pkgs, ...}: {
  imports = [
    ./modules
    ./configs/wsl.nix
    ./configs/home-manager.nix
    ./configs/system-packages.nix
    ./configs/nix.nix
    ./configs/shadowsocks.nix
    ./configs/syncthing.nix
    ./configs/docker.nix
  ];

  my = {
    user = "grig";
    host = "work-wsl";
    windows.user = "grig";
  };

  hardware.keyboard.qmk.enable = true;

  system.stateVersion = "23.11";
}
