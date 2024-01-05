{...}: {
  imports = [./sops.nix];

  sops.secrets = {
    "ssh/vps-nl".path = ".ssh/vps-nl";
    "ssh/vps-no".path = ".ssh/vps-no";
    "ssh/hf".path = ".ssh/hf";
  };

  programs.ssh.matchBlocks = {
    hf = {
      hostName = "hf.co";
      identityFile = ".ssh/hf";
    };
    vps-nl = {
      hostName = "37.1.221.231";
      identityFile = ".ssh/vps-nl";
    };
  };
}
