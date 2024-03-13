{
  pkgs,
  inputs,
  ...
}: let
  keyFile = "/var/lib/sops/keys.txt";
in {
  imports = [inputs.sops-nix.nixosModules.sops];

  sops = {
    age.keyFile = keyFile;
    defaultSopsFile = ../../secrets.yaml;
  };

  environment = {
    variables.SOPS_AGE_KEY_FILE = keyFile;
    systemPackages = with pkgs; [
      sops
      age
    ];
  };
}
