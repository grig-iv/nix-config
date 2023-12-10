{
  pkgs,
  lib,
  ...
}:
with pkgs;
with lib; {
  security.sudo = {
    enable = true;
    extraRules = [
      {
        commands = [
          {
            command = "${getExe systemd}";
            options = ["NOPASSWD"];
          }
          {
            command = "${getExe systemd}";
            options = ["NOPASSWD"];
          }
          {
            command = "${getExe systemd}";
            options = ["NOPASSWD"];
          }
          {
            command = "${getExe wireguard-tools}";
            options = ["NOPASSWD"];
          }
        ];
        groups = ["wheel"];
      }
    ];
  };
}
