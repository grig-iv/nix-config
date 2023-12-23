{pkgs, ...}: let
  packages = ps:
    with ps; [
      python-lsp-server
    ];
in {
  home.packages = with pkgs; [
    (python39.withPackages packages)
  ];
}
