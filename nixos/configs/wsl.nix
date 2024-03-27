{
  lib,
  config,
  inputs,
  ...
}: {
  imports = [inputs.nixos-wsl.nixosModules.default];

  wsl = {
    enable = true;
    defaultUser = config.my.user;
  };

  networking.firewall.enable = lib.mkForce false;
}
