{pkgs, ...}: {
  home.packages = with pkgs; [
    clojure
    clojure-lsp
    leiningen
  ];

  programs.java.enable = true;
}
