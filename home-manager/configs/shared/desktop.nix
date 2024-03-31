{
  pkgs,
  lib,
  ...
}:
with lib; {
  imports = [
    ./shell.nix

    ./../wezterm
    ./../firefox
    ./../redshift.nix
    ./../zathura.nix
    ./../rofi.nix
    ./../unclutter.nix
    ./../feh.nix
    ./../udiskie.nix
    ./../qmk.nix
    ./../vscode.nix
    ./../mpv.nix
    ./../gtk.nix
    ./../sxiv.nix
    #./../dunst.nix
  ];

  home.packages = with pkgs; [
    telegram-desktop

    xclip
    maim
    pulsemixer
  ];
}
