{pkgs, ...}: {
  home.packages = with pkgs; [qmk evtest];
  home.file.".config/qmk/qmk.ini".text = ''
    [user]
    keyboard = crkbd
    keymap = grig-iv
  '';
}
