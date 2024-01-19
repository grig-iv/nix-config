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

  networking.hostName = "work-wsl";

  environment.systemPackages = with pkgs; [
    neovim
    git
    wget
    curl
    unzip
  ];

  system.stateVersion = "23.11";

  services.syncthing = {
    inherit user;
    settings = {
      devices = {
        "phone".id = "WQ2IBG5-LHTOBE5-QAKLUKH-NXKZZZX-SMIMQ7T-2HLUXTM-FNVSH4Z-Y3QTVAD";
        "xtal".id = "Q5QZIKG-DLRF2VN-6PC6TEQ-VT324HL-2DLDYLC-OWPXUMD-4KRLX5X-L76DKQH";
      };
      folders = {
        "Extended Mind" = {
          id = "tcgvs-gd77k";
          path = "/home/${user}/Extended Mind";
          devices = ["phone" "xtal"];
        };
        "Quick Share" = {
          id = "mudfh-6fzjh";
          path = "/home/${user}/Quick Share";
          devices = ["phone" "xtal"];
        };
        "Win Config" = {
          id = "wutmt-nb32y";
          path = "/mnt/c/Users/abstr/.config";
          devices = ["phone"];
        };
      };
    };
  };
}
