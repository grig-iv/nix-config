{pkgs, ...}: {
  home.packages = with pkgs; [
    ocaml
    ocamlformat
    dune_3
    binutils
    pkg-config
    gcc
    gnumake
    openssl
    gmp
    ocamlPackages.ocaml-lsp
    ocamlPackages.ocp-indent
    ocamlPackages.ocamlformat-rpc-lib
  ];

  programs.opam.enable = true;
  programs.vscode.extensions = [pkgs.vscode-extensions.ocamllabs.ocaml-platform];
}
