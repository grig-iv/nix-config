{
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.sops-nix.nixosModules.sops];

  sops = {
    age.keyFile = "/var/lib/sops/keys.txt";
    defaultSopsFile = ../../secrets.yaml;
  };

  environment.systemPackages = with pkgs; [
    sops
    age
  ];
}
