{
  config,
  pkgs,
  unstable,
  ...
}: let
  wslVpnkitSetup = pkgs.writeShellScriptBin "wsl-vpnkit-setup" ''
    #!/bin/bash

    if [[ $EUID -ne 0 ]]; then
        echo "This script must be run as root."
        exit 1
    fi

    cat <<EOL > /etc/systemd/system/wsl-vpnkit.service
    [Unit]
    Description=wsl-vpnKit service

    [Service]
    ExecStart=${unstable.wsl-vpnkit}/bin/wsl-vpnkit
    Restart=always
    User=root
    RemainAfterExit=yes

    [Install]
    WantedBy=multi-user.target
    EOL

    systemctl daemon-reload
    systemctl enable wsl-vpnkit.service
    systemctl start wsl-vpnkit.service

    echo "WSL VPNKit Service has been set up and started"
  '';
in {
  home.packages = [
    wslVpnkitSetup
    unstable.wsl-vpnkit
  ];
}
