{
  pkgs,
  lib,
  ...
}: {
  imports = [
    <nixos-wsl/modules>
    ./configs/nix.nix
    # ./configs/sops.nix
  ];

  wsl = {
    enable = true;
    defaultUser = "grig-wsl";
  };

  environment.systemPackages = with pkgs; [
    neovim
    git
    wget
    curl
    unzip
  ];

  # nixpkgs.hostPlatform = "x86_64-linux";
  # system.stateVersion = "23.11";
}
