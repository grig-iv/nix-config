{
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.sops-nix.homeManagerModules.sops];

  sops = {
    age.keyFile = "/home/grig-iv/.config/sops/age/keys.txt";
    defaultSopsFile = ../../secrets.yaml;
  };

  home.packages = with pkgs; [
    sops
    age
  ];
}
