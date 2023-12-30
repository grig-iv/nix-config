{pkgs, ...}: {
  imports = [
    ./configs/nix.nix
    ./configs/sops.nix
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
