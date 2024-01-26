{
  config,
  lib,
  ...
}: let
  host = config.networking.hostName;
  user = config.services.syncthing.user;
in {
  imports = [./sops.nix];

  sops.secrets."syncthing/key-${host}" = {};
  sops.secrets."syncthing/cert-${host}" = {};
  services.syncthing = {
    enable = true;
    group = "wheel";
    openDefaultPorts = true;
    key = config.sops.secrets."syncthing/key-${host}".path;
    cert = config.sops.secrets."syncthing/cert-${host}".path;
    configDir = "/home/${user}/.config/syncthing";
    extraFlags = ["--no-default-folder"];
    settings = {
      gui.theme = "black";
      options = {
        globalAnnounceEnabled = true;
        urAccepted = -1;
      };
      devices = {
        "phone".id = "WQ2IBG5-LHTOBE5-QAKLUKH-NXKZZZX-SMIMQ7T-2HLUXTM-FNVSH4Z-Y3QTVAD";
        "work-wsl".id = "XWUW5YU-B2MTUK7-33TJ4TM-ZKNMUT3-RAQKWBT-SXBDDUF-4I4EGIZ-OBIXPQP";
        "tha-wsl".id = "HV35JBN-LZLIZWK-KSZTMLD-3J25IYS-DYDYIAN-B3A7LNE-EQIPAJH-AQMVPQR";
        "xtal".id = "Q5QZIKG-DLRF2VN-6PC6TEQ-VT324HL-2DLDYLC-OWPXUMD-4KRLX5X-L76DKQH";
      };
      folders = lib.filterAttrs (n: v: lib.any (d: d == host) v.devices) {
        "Extended Mind" = {
          id = "tcgvs-gd77k";
          path = "/home/${user}/Extended Mind";
          devices = ["phone" "xtal" "tha-wsl" "work-wsl"];
        };
        "Quick Share" = {
          id = "mudfh-6fzjh";
          path = "/home/${user}/Quick Share";
          devices = ["phone" "xtal" "tha-wsl" "work-wsl"];
        };
        "Books" = {
          id = "ztshj-sh3ra";
          path = "/home/${user}/Books";
          devices = ["phone" "xtal" "tha-wsl"];
        };
        "Camera" = {
          id = "7pgoy-oxxrb";
          path = "/home/${user}/Camera";
          devices = ["phone" "xtal" "tha-wsl"];
        };
        "Interlinked Cells" = {
          id = "rfkva-mxs67";
          path = "/home/${user}/Interlinked Cells";
          devices = ["phone" "xtal" "tha-wsl"];
        };
        "Cloud" = {
          id = "rqeqw-kzojx";
          path = "/home/${user}/Cloud";
          devices = ["phone" "xtal" "tha-wsl"];
        };
      };
    };
  };
}
