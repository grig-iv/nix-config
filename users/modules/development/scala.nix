{unstable, ...}: {
  home.packages = with unstable; [
    scala_3
    sbt
    metals
    coursier
    mill
    bloop
  ];

  programs.java.enable = true;
}
