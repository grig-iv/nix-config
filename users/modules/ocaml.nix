{pkgs, ...}: {
  home.packages = with pkgs; [
    ocaml
    dune_3

    ocamlPackages.core

    ocamlPackages.ocaml-lsp
    ocamlPackages.ocp-indent
  ];

  programs.opam.enable = true;
}
