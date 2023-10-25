{pkgs, ...}: {
  home.packages = with pkgs; [
    ocaml
    ocamlformat
    dune_3
    pkgconfig
    gmp
    ocamlPackages.ocaml-lsp
    ocamlPackages.ocp-indent
  ];

  programs.opam.enable = true;
  programs.vscode.extensions = [pkgs.vscode-extensions.ocamllabs.ocaml-platform];
}
