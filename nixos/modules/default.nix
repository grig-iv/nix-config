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
    };
    host = mkOption {
      type = types.str;
    };
  };

  config = {
    networking.hostName = config.my.host;
  };
}
