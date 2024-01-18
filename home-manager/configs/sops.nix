{
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.sops-nix.homeManagerModules.sops];

  sops = {
    age.keyFile = "/var/lib/sops/keys.txt";
    defaultSopsFile = ../../secrets.yaml;
  };

  home.packages = with pkgs; [
    sops
    age
  ];
}
