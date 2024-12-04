{pkgs, ...}: {
  fonts.fontconfig.enable = true;

  home = {
    packages = with pkgs; [
      wezterm
      noto-fonts # amoungus font "ඞ"
    ];
    sessionVariables = {
      TERMINAL = "wezterm";
    };
  };
}
