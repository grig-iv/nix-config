{pkgs, ...}: {
  home.packages = with pkgs; [
    anki-bin
  ];

  # anki needs mpv for audio and video
  programs.mpv.enable = true;
}
