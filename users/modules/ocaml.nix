{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    ocaml
    opam
    ocamlPackages.ocaml-lsp
    dune_3
  ];
}
