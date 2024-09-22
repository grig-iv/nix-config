{...}: {
  programs.zathura = {
    enable = true;
    extraConfig = ''
      include catppuccin-mocha
      set selection-clipboard clipboard
    '';
  };

  xdg = {
    configFile."zathura/catppuccin-mocha".source = builtins.fetchurl {
      url = "https://raw.githubusercontent.com/catppuccin/zathura/0adc53028d81bf047461bc61c43a484d11b15220/src/catppuccin-mocha";
      sha256 = "0r2bgh4y7hymq8hhsjc70aw7yw85v668vgqcrcmdsggvdsk4rv1w";
    };

    mimeApps = {
      enable = true;
      defaultApplications."application/pdf" = "org.pwmt.zathura.desktop";
    };
  };
}
