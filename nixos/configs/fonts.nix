{pkgs, ...}: let
  nerdfonts = pkgs.nerdfonts.override {
    fonts = [
      "JetBrainsMono"
    ];
  };
in {
  fonts.packages = with pkgs; [
    nerdfonts
    font-awesome
    roboto-mono
    times-newer-roman
    raleway
    # google-fonts
  ];

  environment.shellAliases = {
    font-list = "fc-list | sed 's|.*/||'";
    font-find = "font-list | grep -i";
  };
}
