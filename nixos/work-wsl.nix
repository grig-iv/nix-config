{
  pkgs,
  inputs,
  ...
}: let
  user = "grig";
in {
  imports = [
    inputs.nixos-wsl.nixosModules.default

    ./configs/nix.nix
    ./configs/shadowsocks.nix
    ./configs/syncthing.nix
  ];

  wsl = {
    enable = true;
    defaultUser = user;
  };

  services.syncthing = {
    user = user;
    settings.folders.".config-win".path = "/mnt/c/Users/grig/.config";
  };

  networking.hostName = "work-wsl";

  environment.systemPackages = with pkgs; [
    neovim
    git
    wget
    curl
    unzip
  ];

  system.stateVersion = "23.11";
}
