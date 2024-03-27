{...}: {
  imports = [
    ./modules
    ./configs/wsl.nix
    ./configs/home-manager.nix
    ./configs/system-packages.nix
    ./configs/nix.nix
    ./configs/shadowsocks.nix
    ./configs/syncthing.nix
  ];

  my = {
    user = "grig";
    host = "tha-wsl";
    windows.user = "abstr";
  };

  services.syncthing = {
    guiAddress = "127.0.0.1:8385";
    openDefaultPorts = false;
  };

  system.stateVersion = "23.11";
}
