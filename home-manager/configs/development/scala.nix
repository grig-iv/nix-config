{pkgs, ...}: {
  home.packages = with pkgs; [
    scala_3
    scala-cli
    sbt
    metals
    coursier
    mill
    bloop
  ];

  programs.java.enable = true;
}
