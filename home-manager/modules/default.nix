{
  config,
  lib,
  ...
}:
with lib; {
  imports = [
    ./scoop.nix
    ./colors.nix
    ./repositories.nix
  ];

  options.my = {
    hostInfo = {
      isInWsl = mkOption {
        type = types.bool;
        default = false;
        description = "WSL indicator";
      };

      windowsUserPath = mkOption {
        type = types.str;
        default = "/mnt/c/Users/${config.home.username}";
        description = "Path to windows user directory";
      };
    };

    marginBase = mkOption {
      type = types.int;
      default = 8;
      description = "Margin base of screen elements";
    };

    backgroundsDirPath = mkOption {
      type = types.path;
      default = /usr/share/backgrounds;
      description = "Path to wallpaper folder";
    };

    cornerRadius = mkOption {
      type = types.int;
      default = 8;
      description = "Corner radius of applications";
    };

    fontName = mkOption {
      type = types.str;
      default = "JetBrainsMono Nerd Font";
      description = "Main font";
    };
  };
}
