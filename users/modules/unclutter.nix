{
  config,
  pkgs,
  unstable,
  ...
}: let
  myscript = pkgs.writeShellScriptBin "myscript" ''
    #!/bin/sh
    echo "Hello from myscript!"
  '';
in {
  home.packages = [
    unstable.wsl-vpnkit
    myscript
  ];
}
