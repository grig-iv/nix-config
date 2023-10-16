{unstable, ...}: {
  home.packages = with unstable; [
    scala_3
    sbt
    metals
    coursier
    mill
  ];

  programs.java.enable = true;
}
