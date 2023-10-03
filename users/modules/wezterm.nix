{...}: {
  programs.wezterm = {
    enable = true;
    extraConfig = ''
      return {
        color_scheme = "Catppuccin Mocha",
        enable_tab_bar = false,
        disable_default_key_bindings = true,
      }
    '';
  };
}
