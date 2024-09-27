{pkgs, ...}: let
  catppuccin = {
    christmas = pkgs.fetchurl {
      url = "https://w.wallhaven.cc/full/zx/wallhaven-zxepdo.jpg";
      sha256 = "sha256-+qPJykyumycM1xGH7fqUZYaw+S+GJanRr5EAWVcqOz8=";
    };
    mounatins-1 = pkgs.fetchurl {
      url = "https://unsplash.com/photos/Nz-9aluYRWE/download?ixid=M3wxMjA3fDB8MXxjb2xsZWN0aW9ufDd8NDk4MDgyMDJ8fHx8fDJ8fDE3MDUyMjk1MjV8&force=true&w=1920";
      sha256 = "sha256-WYMuilnTbC2wasmR8sVR0K5Id5wRbo3xsH8+aG2Zvwg=";
    };
    mounatins-2 = pkgs.fetchurl {
      url = "https://images.unsplash.com/photo-1589405858862-2ac9cbb41321?q=80&w=2670&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D";
      sha256 = "sha256-9yms2LOMfPXgXKciDi1QoWly3adt04Ybq1dWgwU/Wdk=";
    };
  };
in {
  programs.feh = {
    enable = true;
  };

  xsession.initExtra = ''
    if [ -f $HOME/.config/wallpaper.tif ]; then
        feh --bg-fill $HOME/.config/wallpaper.tif
    else
        feh --bg-fill ${catppuccin.mounatins-2}
    fi
  '';
}
