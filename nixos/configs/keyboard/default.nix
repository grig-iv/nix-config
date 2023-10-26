{...}: {
  services.xserver = {
    layout = "us,ru-g";
    xkbOptions = "grp:alt_shift_toggle,lv3:ralt_switch";
    extraLayouts.ru-g = {
      description = "Grig RU layout";
      languages = ["ru"];
      symbolsFile = ./layout-ru.xkb;
    };
  };

  hardware.keyboard.qmk.enable = true;
}
