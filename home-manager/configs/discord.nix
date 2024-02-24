{pkgs, ...}: {
  # home.packages = with pkgs; [discord];

  # kinda work
  programs.discocss = {
    enable = true;
    discordPackage = pkgs.discord.override {withOpenASAR = true;};
    css = builtins.readFile (builtins.fetchurl {
      url = "https://catppuccin.github.io/discord/dist/catppuccin-mocha.theme.css";
      sha256 = "1xfi3pqkwvwr4sjxdrz07d7pvmpxnc71xk43xv10pxcficb5rgs4";
    });
  };
}
