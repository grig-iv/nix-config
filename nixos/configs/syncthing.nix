{config, ...}: let
  host = config.networking.hostName;
in {
  sops.secrets."syncthing/key-${host}" = {};
  sops.secrets."syncthing/cert-${host}" = {};
  services.syncthing = {
    enable = true;
    group = "wheel";
    openDefaultPorts = true;
    key = config.sops.secrets."syncthing/key-${host}".path;
    cert = config.sops.secrets."syncthing/cert-${host}".path;
    configDir = "/home/${config.services.syncthing.user}/.config/syncthing";
    extraFlags = ["--no-default-folder"];
    settings = {
      gui.theme = "black";
      options = {
        globalAnnounceEnabled = false;
        urAccepted = -1;
      };
    };
  };
}
