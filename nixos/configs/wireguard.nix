{config, ...}: {
  imports = [./sops.nix];

  sops.secrets."wireguard/config-xtal" = {};

  networking = {
    firewall.allowedUDPPorts = [51820];
    wg-quick.interfaces.wg0 = {
      autostart = false;
      configFile = config.sops.secrets."wireguard/config-xtal".path;
    };
  };

  security.polkit = {
    enable = true;
    extraConfig = ''
      polkit.addRule(function(action, subject) {
        if (action.id == "org.freedesktop.systemd1.manage-units" &&
            subject.user == "${config.my.user}") {
          return polkit.Result.YES;
        }
      });
    '';
  };

  environment.shellAliases = {
    vpn-on = "systemctl start wg-quick-wg0.service";
    vpn-off = "systemctl stop wg-quick-wg0.service";
  };
}
