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
}
