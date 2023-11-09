{unstable, ...}: {
  home.packages = with unstable; [
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
