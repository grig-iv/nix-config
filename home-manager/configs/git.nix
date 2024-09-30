{...}: {
  imports = [./sops.nix];

  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "grig-iv";
    userEmail = "abstractgrig@gmail.com";
    extraConfig = {
      pull.rebase = false;
      safe = {
        "directory" = "/etc/nixos";
      };
    };
  };

  sops.secrets."ssh/github".path = ".ssh/github";
  programs.ssh = {
    enable = true;
    matchBlocks.github = {
      host = "github.com";
      identityFile = "~/.ssh/github";
    };
  };
}
