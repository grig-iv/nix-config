{config, ...}: {
  programs.tmux = {
    enable = true;
    escapeTime = 0;
    baseIndex = 1;
    keyMode = "vi";
    newSession = true;
    terminal = "xterm-256color";
  };
}
