{config, ...}: {
  imports = [./gitui.nix];

  programs.git = {
    enable = true;
    userName = "grig-iv";
    userEmail = "abstractgrig@gmail.com";
    extraConfig = {
      safe = {
        "directory" = "/etc/nixos";
      };
    };
  };
}
