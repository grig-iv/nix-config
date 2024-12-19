{
  pkgs,
  lib,
  ...
}: {
  home = {
    packages = with pkgs; [wslu];
  };

  my = {
    hostInfo = {
      isInWsl = true;
      windowsUserPath = lib.mkDefault "/mnt/c/Users/abstr/";
    };
  };
}
