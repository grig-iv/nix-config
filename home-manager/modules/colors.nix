{
  config,
  lib,
  ...
}:
with lib; let
  colors = config.my.colors;
  mkColor = color:
    mkOption {
      type = types.str;
      default = color;
    };
in {
  options.my.colors = {
    # general
    primary = mkColor colors.sky;
    accent = mkColor colors.peach;
    critical = mkColor colors.red;
    warning = mkColor colors.yellow;

    # syntax
    keyword = mkColor colors.red;
    variable = mkColor colors.text;
    function = mkColor colors.green;
    type = mkColor colors.sapphire;
    string = mkColor colors.yellow;
    comment = mkColor colors.surface2;
    property = mkColor colors.blue;
    parameter = mkColor colors.peach;
    constant = mkColor colors.mauve;

    # neutrals
    text = mkColor "#cdd6f4";
    subtext1 = mkColor "#bac2de";
    subtext0 = mkColor "#a6adc8";
    overlay2 = mkColor "#9399b2";
    overlay1 = mkColor "#7f849c";
    overlay0 = mkColor "#6c7086";
    surface2 = mkColor "#585b70";
    surface1 = mkColor "#45475a";
    surface0 = mkColor "#313244";
    base = mkColor "#1e1e2e";
    mantle = mkColor "#181825";
    crust = mkColor "#11111b";

    # general colors
    red = mkColor "#f38ba8";
    pink = mkColor "#f5c2e7";
    yellow = mkColor "#f9e2af";
    orange = mkColor colors.peach;
    green = mkColor "#a6e3a1";
    blue = mkColor "#89b4fa";

    # catppuccin colors
    rosewater = mkColor "#f5e0dc";
    flamingo = mkColor "#f2cdcd";
    mauve = mkColor "#cba6f7";
    maroon = mkColor "#eba0ac";
    peach = mkColor "#fab387";
    teal = mkColor "#94e2d5";
    sky = mkColor "#89dceb";
    sapphire = mkColor "#74c7ec";
    lavender = mkColor "#b4befe";
  };

  options.my.colors' = mkOption {
    type = types.attrs;
  };

  config = with lib; {
    my.colors' = mapAttrs (n: v: removePrefix "#" v) colors;

    xdg.configFile."colors/colors.lua".text = ''
      local M = {}

      ${(concatStringsSep "\n" (mapAttrsToList (n: v: "M['${n}'] = '${v}'") colors))}

      return M
    '';
  };
}
