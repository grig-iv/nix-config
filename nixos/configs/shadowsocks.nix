{
  pkgs,
  config,
  ...
}: {
  sops.secrets."shadowsocks/vps-no" = {};

  systemd.services.shadowsocks-client = {
    description = "Shadowsocks Client Service";
    after = ["network.target"];
    wantedBy = ["multi-user.target"];

    serviceConfig = {
      ExecStart = "${pkgs.shadowsocks-rust}/bin/sslocal -c ${config.sops.secrets."shadowsocks/vps-no".path}";
      Restart = "on-failure";
    };
  };
}
