{config, ...}: {
  networking = {
    hostName = config.my.host;
    firewall.enable = true;
  };
}
