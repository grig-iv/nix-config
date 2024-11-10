{pkgs, ...}: {
  home.packages = with pkgs; [xcolor];

  services.sxhkd.keybindings = {
    "super + alt + c" = "xcolor -s";
  };
}
