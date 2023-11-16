{pkgs, ...}: let
  tmuxRun = pkgs.writeShellScriptBin "tmux-run" ''
    if [ -z "$TMUX" ]; then
        tmux attach -t main || tmux new -s main
    fi
  '';
in {
  programs.tmux = {
    enable = true;
    prefix = "M-Space";
    escapeTime = 50;
    baseIndex = 1;
    keyMode = "vi";
    newSession = true;
    mouse = true;
    terminal = "tmux-256color";
    shell = "${pkgs.fish}/bin/fish";
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

      bind rc source-file ~/.config/tmux/tmux.conf \; display "Reloaded!"
      bind c new-window -c "#{pane_current_path}"
      bind | split-window -h -c "#{pane_current_path}"
      bind _ split-window -v -c "#{pane_current_path}"

      # Alt bindings
      bind -n M-c new-window -c "#{pane_current_path}"
      bind -n M-w confirm-before -p "kill-window #W? (y/n)" kill-pane

      bind -n M-h split-window -h -c "#{pane_current_path}"
      bind -n M-v split-window -v -c "#{pane_current_path}"

      bind -n M-C-PgUp previous-window
      bind -n M-C-PgDn next-window

      is_vim="ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?\.?(view|n?vim?x?)(-wrapped)?(diff)?$'"

      bind-key -n "M-Left" if-shell "$is_vim" "send-keys M-Left" { if -F "#{pane_at_left}" "" "select-pane -L" }
      bind-key -n "M-Down" if-shell "$is_vim" "send-keys M-Down" { if -F "#{pane_at_bottom}" "" "select-pane -D" }
      bind-key -n "M-Up" if-shell "$is_vim" "send-keys M-Up" { if -F "#{pane_at_top}" "" "select-pane -U" }
      bind-key -n "M-Right" if-shell "$is_vim" "send-keys M-Right" { if -F "#{pane_at_right}" "" "select-pane -R" }

      bind-key -T copy-mode-vi "M-Left" if -F "#{pane_at_left}" "" "select-pane -L"
      bind-key -T copy-mode-vi "M-Down" if -F "#{pane_at_bottom}" "" "select-pane -D"
      bind-key -T copy-mode-vi "M-Up" if -F "#{pane_at_top}" "" "select-pane -U"
      bind-key -T copy-mode-vi "M-Right" if -F "#{pane_at_right}" "" "select-pane -R"
    '';
  };

  home.packages = with pkgs; [
    teamocil
    tmuxRun
  ];

  home.file.".teamocil/main.yml".text = ''
    windows:
      - name: shell
        root: ~/
  '';
}
