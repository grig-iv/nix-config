{
  config,
  pkgs,
  ...
}: {
  programs.tmux = {
    enable = true;
    escapeTime = 0;
    baseIndex = 1;
    keyMode = "vi";
    newSession = true;
    mouse = true;
    terminal = "screen-256color";
    plugins = with pkgs.tmuxPlugins; [
      catppuccin
    ];
  };

  programs.fish = {
    shellInit = pkgs.lib.mkAfter ''
      if not set -q TMUX
          tmux
      end
    '';
  };

  home.packages = with pkgs; [
    teamocil
  ];

  home.file.".teamocil/main.yml".text = ''
    windows:
      - name: shell
        root: ~/
  '';
}
