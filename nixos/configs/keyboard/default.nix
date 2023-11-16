{pkgs, ...}: let
  xmodmap = pkgs.writeText ".Xmodmap" ''
    keycode 191 = F13 F13 F13 F13 F13 F13
    keycode 192 = F14 F14 F14 F14 F14 F14
    keycode 193 = F15 F15 F15 F15 F15 F15
    keycode 194 = F16 F16 F16 F16 F16 F16
    keycode 195 = F17 F17 F17 F17 F17 F17
    keycode 196 = F18 F18 F18 F18 F18 F18
    keycode 197 = F19 F19 F19 F19 F19 F19
    keycode 198 = F20 F20 F20 F20 F20 F20
    keycode 199 = F21 F21 F21 F21 F21 F21
    keycode 200 = F22 F22 F22 F22 F22 F22
    keycode 201 = F23 F23 F23 F23 F23 F23
    keycode 202 = F24 F24 F24 F24 F24 F24

    key <RALT> {
      type[Group1]="TWO_LEVEL",
      [ ISO_Level3_Shift, Multi_key ]
    };
  '';
in {
  services.xserver = {
    layout = "us,ru-g";
    xkbOptions = "grp:alt_shift_toggle,lv3:ralt_switch";
    extraLayouts.ru-g = {
      description = "Grig RU layout";
      languages = ["ru"];
      symbolsFile = ./layout-ru.xkb;
    };
    displayManager.sessionCommands = "${pkgs.xorg.xmodmap}/bin/xmodmap ${xmodmap}";
  };

  hardware.keyboard.qmk.enable = true;
}
