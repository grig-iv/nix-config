{
  config,
  lib,
  ...
}: let
  host = config.my.host;
  user = config.my.user;
  homePath = "/home/${user}";
  cloudPath = "${homePath}/cloud";
  hasCloud = lib.hasAttr "Cloud" config.services.syncthing.settings.folders;
in
  with lib; {
    imports = [./sops.nix];

    sops.secrets."syncthing/key-${host}" = {};
    sops.secrets."syncthing/cert-${host}" = {};
    services.syncthing = {
      enable = false;
      user = user;
      group = "wheel";
      openDefaultPorts = mkDefault true;
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
          "tha-wsl".id = "SOQ6HXT-ZGVK6BQ-FOOWUEI-TIH4CQT-4A6ALQV-FKWNRX5-4IAT5XS-7S3GRQO";
          "tha-mili".id = "HV35JBN-LZLIZWK-KSZTMLD-3J25IYS-DYDYIAN-B3A7LNE-EQIPAJH-AQMVPQR";
          "xtal".id = "Q5QZIKG-DLRF2VN-6PC6TEQ-VT324HL-2DLDYLC-OWPXUMD-4KRLX5X-L76DKQH";
        };
        folders = filterAttrs (n: v: any (d: d == host) v.devices) {
          "Mind" = {
            id = "tcgvs-gd77k";
            path = "${homePath}/mind";
            devices = ["phone" "xtal" "tha-wsl" "work-wsl"];
          };
          "Quick Share" = {
            id = "mudfh-6fzjh";
            path = "${homePath}/quick-share";
            devices = ["phone" "xtal" "tha-wsl" "work-wsl"];
          };
          ".config-win" = {
            id = "wutmt-nb32y";
            path = "/mnt/c/Users/" + config.my.windows.user + "/.config";
            devices = ["phone" "tha-wsl" "work-wsl"];
          };
          "Books" = {
            id = "ztshj-sh3ra";
            path = "${homePath}/books";
            devices = ["phone" "xtal" "tha-wsl"];
          };
          "Camera" = {
            id = "7pgoy-oxxrb";
            path = "${homePath}/camera";
            devices = ["phone" "xtal" "tha-wsl"];
          };
          "Cloud" = {
            id = "rqeqw-kzojx";
            path = cloudPath;
            devices = ["phone" "xtal" "tha-wsl"];
          };
          "Music" = {
            id = "music";
            path = "${homePath}/music";
            devices = ["phone" "xtal" "tha-wsl"];
          };
        };
      };
    };
  }
