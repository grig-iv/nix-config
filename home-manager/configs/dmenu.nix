{pkgs, ...}: {
  home.packages = with pkgs; [dmenu];
  services.sxhkd.keybindings = {
    "super + alt + p" = "${pkgs.dmenu}/bin/dmenu_run";
  };
}
