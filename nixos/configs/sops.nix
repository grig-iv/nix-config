{
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.sops-nix.nixosModules.sops];

  sops = {
    age.keyFile = "/home/grig-iv/.config/sops/age/keys.txt";
    defaultSopsFile = ../../secrets.yaml;
  };

  environment.systemPackages = with pkgs; [
    sops
    age
  ];
}
