{pkgs, ...}: let
  nerdfonts = pkgs.nerdfonts.override {
    fonts = [
      "JetBrainsMono"
    ];
  };
in {
  fonts.fonts = with pkgs; [
    nerdfonts
    font-awesome
    roboto-mono
  ];

  environment.shellAliases = {
    font-list = "fc-list | sed 's|.*/||'";
    font-find = "font-list | grep ";
  };
}
