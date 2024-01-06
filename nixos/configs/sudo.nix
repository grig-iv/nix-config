{
  pkgs,
  lib,
  ...
}: {
  security.sudo = {
    enable = true;
    extraRules = [
      {
        commands = [
          {
            command = lib.getExe pkgs.nixos-rebuild;
            options = ["NOPASSWD"];
          }
        ];
        groups = ["wheel"];
      }
    ];
  };
}
