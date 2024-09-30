{
  pkgs,
  lib,
  ...
}: {
  systemd.services.keylogger = {
    wantedBy = ["multi-user.target"];
    serviceConfig = {
      ExecStart = "/bin/sh -c '${lib.getExe pkgs.hid-listen} | egrep --line-buffered \"(0x[A-F0-9]+,)?[0-9]+,[0-9]+,[0-9]{1,2}\"'";
      StandardOutput = "append:/var/log/keylog.csv";
    };
  };
}
