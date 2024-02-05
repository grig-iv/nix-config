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

  services.syncthing = {
    user = user;
    settings.folders.".config-win".path = "/mnt/c/Users/abstr/.config";
  };

  wsl = {
    enable = true;
    defaultUser = user;
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
