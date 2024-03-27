{pkgs, ...}: {
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
    host = "work-wsl";
    windows.user = "grig";
  };

  environment.systemPackages = with pkgs; [
    zathura
  ];

  system.stateVersion = "23.11";
}
