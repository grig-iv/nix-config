{pkgs, ...}: {
  home.packages = with pkgs; [
    clojure
    clojure-lsp
    leiningen
  ];

  programs.java.enable = true;

  programs.vscode = {
    extensions = with pkgs.vscode-extensions; [
      betterthantomorrow.calva
    ];
  };
}
