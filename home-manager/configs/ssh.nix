{...}: {
  imports = [./sops.nix];

  sops.secrets = {
    "ssh/vps-nl".path = ".ssh/vps-nl";
    "ssh/vps-no".path = ".ssh/vps-no";
    "ssh/hf".path = ".ssh/hf";
  };

  programs.ssh = {
    enable = true;
    matchBlocks = {
      hf = {
        host = "hf.co";
        identityFile = "~/.ssh/hf";
      };
      vps-nl = {
        host = "37.1.221.231";
        identityFile = "~/.ssh/vps-nl";
        hostname = "vps-nl";
      };
    };
  };
}
