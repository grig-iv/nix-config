{
  config,
  pkgs,
  ...
}: let
  listenPort = 51820;
  publicKey = "LBrqCYtKPNZYvoGj5pk3PKW2pzTQQxd1ZoLGnh8RmhY=";
in {
  environment.systemPackages = with pkgs; [wireguard-tools];

  sops.secrets."wireguard/privateKey" = {};

  networking = {
    firewall.allowedUDPPorts = [listenPort];
    nameservers = ["94.140.14.14" "94.140.15.15"];
    wireguard.interfaces.wg0 = {
      ips = ["192.168.40.12/24"];
      privateKeyFile = config.sops.secrets."wireguard/privateKey".path;
      listenPort = listenPort;
      postSetup = ["wg set wg0 peer ${publicKey} persistent-keepalive 25"];
      peers = [
        {
          inherit publicKey;
          allowedIPs = ["0.0.0.0/0"];
          endpoint = "37.1.221.231:51820";
        }
      ];
    };
  };
}
