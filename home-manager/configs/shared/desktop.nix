{
  pkgs,
  lib,
  inputs,
  unstable,
  ...
}: let
  autostart = pkgs.writeShellScriptBin "autostart" ''
    set-wallpaper
  '';
in
  with lib; {
    imports = [
      inputs.nix-colors.homeManagerModules.default

      ./shell.nix

      ./../wezterm
      ./../firefox
      ./../redshift.nix
      ./../zathura.nix
      ./../rofi.nix
      ./../unclutter.nix
      ./../feh.nix
      ./../wireguard.nix
      ./../udiskie.nix
      ./../qmk.nix
      ./../vscode.nix
      ./../mpv.nix
      #./../gtk.nix
      #./../dunst.nix
      #./../picom.nix
    ];

    home.packages = with pkgs; [
      autostart

      unstable.telegram-desktop

      xclip
      maim
      sxiv
      pulsemixer
    ];

    colorScheme = {
      slug = "catppuccin";
      name = "Catppuccin";
      colors = {
        base00 = "1e1e2e"; # base
        base01 = "181825"; # mantle
        base02 = "313244"; # surface0
        base03 = "45475a"; # surface1
        base04 = "585b70"; # surface2
        base05 = "cdd6f4"; # text
        base06 = "f5e0dc"; # rosewater
        base07 = "b4befe"; # lavender
        base08 = "f38ba8"; # red
        base09 = "fab387"; # peach
        base0A = "f9e2af"; # yellow
        base0B = "a6e3a1"; # green
        base0C = "94e2d5"; # teal
        base0D = "89b4fa"; # blue
        base0E = "cba6f7"; # mauve
        base0F = "f2cdcd"; # flamingo
      };
    };

    home.sessionVariables = {
      BROWSER = "firefox";
      TERMINAL = "wezterm";
    };
  }
