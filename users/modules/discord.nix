{pkgs, ...}: {
  home.packages = with pkgs; [(discord-ptb.override {withOpenASAR = true;})];

  # don't work
  /*
  programs.discocss = {
    enable = true;
    discordPackage = pkgs.discord.override {withOpenASAR = true;};
    css = builtins.readFile (builtins.fetchurl {
      url = "https://catppuccin.github.io/discord/dist/catppuccin-mocha.theme.css";
      sha256 = "01z7ygnfghvpdknms71c31783lwv55gibhrlcr4nvng4k548sahc";
    });
  };
  */
}
