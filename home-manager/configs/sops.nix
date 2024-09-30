{pkgs, ...}: {
  sops = {
    age.keyFile = "/var/lib/sops/key";
    defaultSopsFile = ../../secrets.yaml;
  };

  home.packages = with pkgs; [
    sops
    age
  ];
}
