{pkgs, ...}: {
  programs.rbw = {
    enable = true;
  };

  programs.fish.shellAbbrs."bwg" = "rbw get --clipboard";

  sops.secrets = {
    "rbw-cofig".path = ".config/rbw/config.json";
  };
}
