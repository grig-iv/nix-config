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
        users."${user}" = import (../home-manager + "/grig@tha-wsl.nix");
      };
    }

    ./configs/nix.nix
    ./configs/syncthing.nix
  ];

  wsl = {
    enable = true;
    defaultUser = user;
  };

  services.syncthing = {
    user = user;
    settings.folders.".config-win".path = "/mnt/c/Users/abstr/.config";
    guiAddress = "127.0.0.1:8385";
    openDefaultPorts = false;
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
