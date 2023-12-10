{
  pkgs,
  lib,
  ...
}: let
  redshift-toggle = pkgs.writeShellScriptBin "redshift-toggle" ''
    if systemctl --user is-active --quiet redshift.service; then
        echo "Stopping Redshift service..."
        systemctl --user stop redshift.service
    else
        echo "Starting Redshift service..."
        systemctl --user start redshift.service
    fi
  '';
in {
  services.redshift = {
    enable = true;
    temperature.night = 2800;
    latitude = 59.951828;
    longitude = 30.342980;
  };

  services.sxhkd.keybindings = {
    "super + t; r" = lib.getExe redshift-toggle;
  };

  home.packages = [redshift-toggle];
}
