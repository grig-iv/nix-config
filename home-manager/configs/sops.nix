{
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.sops-nix.homeManagerModules.sops];

  sops = {
    age.keyFile = "/var/lib/key.age";
    defaultSopsFile = ../../secrets.yaml;
  };

  home.packages = with pkgs; [
    sops
    age
  ];
}
