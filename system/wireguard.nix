{
  config,
  pkgs,
  ...
}: let
  listenPort = 51820;
in {
  environment.systemPackages = with pkgs; [wireguard-tools];

  sops.secrets."wireguard/privateKey" = {};

  networking = {
    firewall.allowedUDPPorts = [listenPort];
    nameservers = ["94.140.14.14" "94.140.15.15"];
    wireguard.interfaces.wg0 = {
      ips = ["192.168.40.12"];
      privateKeyFile = config.sops.secrets."wireguard/privateKey".path;
      listenPort = listenPort;
      allowedIPsAsRoutes = true;

      peers = [
        {
          publicKey = "LBrqCYtKPNZYvoGj5pk3PKW2pzTQQxd1ZoLGnh8RmhY=";
          allowedIPs = ["0.0.0.0/0" "::/0"];
          endpoint = "37.1.221.231:51820";
        }
      ];
    };
  };
}
