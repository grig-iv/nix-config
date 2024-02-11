{...}: {
  imports = [./sops.nix];

  sops.secrets = {
    "ssh/vps-nl".path = ".ssh/vps-nl";
    "ssh/vps-no".path = ".ssh/vps-no";
    "ssh/vps-golden-ratio".path = ".ssh/vps-golden-ratio";
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
        hostname = "37.1.221.231";
      };
      vps-no = {
        host = "38.180.77.225";
        identityFile = "~/.ssh/vps-no";
        hostname = "38.180.77.225";
      };
      vps-golden-ratio = {
        host = "5.8.51.147";
        identityFile = "~/.ssh/vps-golden-ratio";
        hostname = "5.8.51.147";
      };
    };
  };
}
