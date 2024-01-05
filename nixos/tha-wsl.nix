{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.nixos-wsl.nixosModules.default

    ./configs/nix.nix
  ];

  wsl = {
    enable = true;
    defaultUser = "grig-wsl";
  };

  networking.hostName = "xtal";

  environment.systemPackages = with pkgs; [
    neovim
    git
    wget
    curl
    unzip
  ];

  system.stateVersion = "23.11";
}
