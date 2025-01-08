{pkgs, ...}: {
  programs.proxychains = {
    enable = true;
    quietMode = true;
    proxyDNS = false;
    package = pkgs.proxychains-ng;
    proxies = {
      default = {
        enable = true;
        type = "socks5";
        host = "127.0.0.1";
        port = 1081;
      };
    };
  };
}
