{...}: {
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      return {
        color_scheme = "Catppuccin Mocha",
        enable_tab_bar = false
      }
    '';
  };
}
