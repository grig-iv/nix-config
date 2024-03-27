{
  config,
  lib,
  ...
}:
with lib; {
  imports = [
    ./wsl.nix
  ];

  options.my = {
    user = mkOption {
      type = types.str;
      default = "grig";
    };
    host = mkOption {
      default = config.networking.hostName;
      type = types.str;
    };
  };
}
