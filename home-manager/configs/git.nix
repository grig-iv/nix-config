{...}: {
  imports = [
    ./gitui.nix
    ./sops.nix
  ];

  programs.git = {
    enable = true;
    lfs.enable = true;
    userName = "grig-iv";
    userEmail = "abstractgrig@gmail.com";
    extraConfig = {
      safe = {
        "directory" = "/etc/nixos";
      };
    };
  };

  sops.secrets."ssh/github".path = ".ssh/github";
  programs.ssh.matchBlocks.github = {
    hostName = "github.com";
    identityFile = ".ssh/github";
  };
}
