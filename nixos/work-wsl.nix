{
  pkgs,
  inputs,
  ...
}: let
  user = "grig";
in {
  imports = [
    inputs.nixos-wsl.nixosModules.default
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager = {
        sharedModules = [inputs.sops-nix.homeManagerModules.sops];
        extraSpecialArgs = {inherit inputs;};
        useGlobalPkgs = true;
        useUserPackages = true;
        users.grig = import (../home-manager + "/grig@work-wsl.nix");
      };
    }

    ./configs/nix.nix
    ./configs/shadowsocks.nix
    ./configs/syncthing.nix
  ];

  networking.hostName = "work-wsl";

  wsl = {
    enable = true;
    defaultUser = user;
  };

  services.syncthing = {
    user = user;
    settings.folders.".config-win".path = "/mnt/c/Users/grig/.config";
  };

  environment.systemPackages = with pkgs; [
    neovim
    git
    wget
    curl
    unzip
  ];

  system.stateVersion = "23.11";
}
