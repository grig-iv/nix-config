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
    terminal = "tmux-256color";
    plugins = with pkgs.tmuxPlugins; [
      {
        plugin = catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavour 'mocha'
        '';
      }
    ];

    extraConfig = ''
      set-option -sa terminal-overrides ",xterm*:Tc"
      set-option -g status-position top

      bind c new-window -c "#{pane_current_path}"
      bind | split-window -h -c "#{pane_current_path}"
      bind _ split-window -v -c "#{pane_current_path}"
    '';
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
