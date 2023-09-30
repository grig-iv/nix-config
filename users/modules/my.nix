{
  config,
  lib,
  ...
}:
with lib; {
  options.my.hostInfo.isInWsl = mkOption {
    type = types.bool;
    default = false;
    description = "WSL indicator";
  };

  options.my.marginBase = mkOption {
    type = types.int;
    default = 8;
    description = "Margin base of screen elements";
  };

  options.my.backgroundsDirPath = mkOption {
    type = types.path;
    default = /usr/share/backgrounds;
    description = "Path to wallpaper folder";
  };

  options.my.cornerRadius = mkOption {
    type = types.int;
    default = 8;
    description = "Corner radius of applications";
  };

  options.my.fontName = mkOption {
    type = types.str;
    default = "JetBrainsMono Nerd Font";
    description = "Main font";
  };

  options.my.colors.base16 = mkOption {
    type = types.attrs;
    default = config.colorScheme.colors;
    description = "Base16 theme's colors";
  };
}
