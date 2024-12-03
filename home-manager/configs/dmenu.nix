{pkgs, ...}: {
  home.packages = with pkgs; [dmenu];
  services.sxhkd.keybindings = {
    "super + p" = "${pkgs.dmenu}/bin/dmenu_run";
  };
}
