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
            command = "${getExe wireguard-tools}";
            options = ["NOPASSWD"];
          }
        ];
        groups = ["wheel"];
      }
    ];
  };
}
