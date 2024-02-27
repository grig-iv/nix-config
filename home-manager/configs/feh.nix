{pkgs, ...}: let
  catppuccin = {
    christmas = pkgs.fetchurl {
      url = "https://w.wallhaven.cc/full/zx/wallhaven-zxepdo.jpg";
      sha256 = "sha256-+qPJykyumycM1xGH7fqUZYaw+S+GJanRr5EAWVcqOz8=";
    };
    mounatins = pkgs.fetchurl {
      url = "https://unsplash.com/photos/Nz-9aluYRWE/download?ixid=M3wxMjA3fDB8MXxjb2xsZWN0aW9ufDd8NDk4MDgyMDJ8fHx8fDJ8fDE3MDUyMjk1MjV8&force=true&w=1920";
      sha256 = "sha256-WYMuilnTbC2wasmR8sVR0K5Id5wRbo3xsH8+aG2Zvwg=";
    };
  };
  set-wallpaper = pkgs.writeShellScriptBin "set-wallpaper" ''
    feh --bg-fill ${catppuccin.mounatins}*
  '';
in {
  home.packages = [set-wallpaper];
  programs.feh = {
    enable = true;
  };
}
