{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    neovim
    git
    wget
    curl
    unzip
  ];
}
