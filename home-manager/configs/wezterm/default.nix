{
  pkgs,
  unstable,
  ...
}: {
  programs.wezterm = {
    enable = true;
    # package = unstable.wezterm;
    extraConfig = builtins.readFile ./wezterm.lua;
  };

  fonts.fontconfig.enable = true;

  home = {
    packages = with pkgs; [
      noto-fonts # amoungus font "ඞ"
    ];
    sessionVariables = {
      TERMINAL = "wezterm";
    };
  };
}
