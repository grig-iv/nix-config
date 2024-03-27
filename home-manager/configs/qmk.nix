{pkgs, ...}: {
  home.packages = with pkgs; [qmk evtest];
  xdg.configFile."qmk/qmk.ini".text = ''
    [user]
    keyboard = crkbd
    keymap = grig-iv
  '';
}
