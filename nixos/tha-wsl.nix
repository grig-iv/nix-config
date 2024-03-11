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
    ./configs/syncthing.nix
  ];

  wsl = {
    enable = true;
    defaultUser = "grig";
  };

  services.syncthing = {
    user = user;
    settings.folders.".config-win".path = "/mnt/c/Users/abstr/.config";
    openDefaultPorts = false;
    extraFlags = ["--listen" "0.0.0.0:22001"];
    localAnnouncePort = 21028;
  };

  networking.hostName = "tha-wsl";

  environment.systemPackages = with pkgs; [
    neovim
    git
    wget
    curl
    unzip
  ];

  system.stateVersion = "23.11";
}
