{
  unstable,
  config,
  ...
}: {
  sops.secrets = {
    "shadowsocks/vps-no" = {};
    "shadowsocks/vps-nl" = {};
  };

  systemd.services = {
    shadowsocks-client-no = {
      description = "Shadowsocks Client Service | NO";
      after = ["network.target"];
      wantedBy = ["multi-user.target"];
      serviceConfig = {
        ExecStart = "${unstable.shadowsocks-rust}/bin/sslocal -c ${config.sops.secrets."shadowsocks/vps-no".path}";
        Restart = "on-failure";
      };
    };
    shadowsocks-client-nl = {
      description = "Shadowsocks Client Service | NL";
      after = ["network.target"];
      wantedBy = ["multi-user.target"];
      serviceConfig = {
        ExecStart = "${unstable.shadowsocks-rust}/bin/sslocal -c ${config.sops.secrets."shadowsocks/vps-nl".path}";
        Restart = "on-failure";
      };
    };
  };
}
