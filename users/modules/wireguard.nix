{pkgs, ...}: {
 home.packages = with pkgs; [wireguard-tools];

  home.shellAliases = {
    vpn-on = "wg-quick up $CONFIG/wireguard/peer.conf";
    vpn-off = "wg-quick down $CONFIG/wireguard/peer.conf";
  }; 
}
