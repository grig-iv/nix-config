{
  pkgs,
  lib,
  ...
}: let
  mainSession = pkgs.writeText "main.yaml" ''
    session_name: main
    windows:
      - panes:
          - cd "Extended Mind" & nvim index.md
      - panes:
          - exit
  '';
  tmuxRun = pkgs.writeShellScriptBin "tmux-run" ''
    if [ -z "$TMUX" ]; then
        tmux attach -t main || tmuxp load ${mainSession}
    fi
  '';
in {
  home.packages = [tmuxRun];

  programs.tmux = {
    enable = true;
    prefix = "M-Space";
    escapeTime = 50;
    baseIndex = 1;
    keyMode = "vi";
    newSession = true;
    mouse = true;
    terminal = "tmux-256color";
    shell = lib.getExe pkgs.fish;
    tmuxp.enable = true;
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

      set -g status-bg default
      set -g status-style bg=default

      bind rc source-file ~/.config/tmux/tmux.conf \; display "Reloaded!"

      # Tmux only bindings
      bind -n M-n new-window -c "#{pane_current_path}"
      bind -n M-q confirm-before -p "kill-window #W? (y/n)" kill-pane

      bind -n M-h split-window -h -c "#{pane_current_path}"
      bind -n M-v split-window -v -c "#{pane_current_path}"

      bind -n M-C-PgUp previous-window
      bind -n M-C-PgDn next-window

      # Vim pass through

      is_vim="ps -o state= -o comm= -t '#{pane_tty}' | grep -iqE '^[^TXZ ]+ +(\\S+\\/)?g?\.?(view|n?vim?x?)(-wrapped)?(diff)?$'"

      # Navigation
      bind -n "M-Left" if-shell "$is_vim" "send-keys M-Left" { if -F "#{pane_at_left}" "" "select-pane -L" }
      bind -n "M-Down" if-shell "$is_vim" "send-keys M-Down" { if -F "#{pane_at_bottom}" "" "select-pane -D" }
      bind -n "M-Up" if-shell "$is_vim" "send-keys M-Up" { if -F "#{pane_at_top}" "" "select-pane -U" }
      bind -n "M-Right" if-shell "$is_vim" "send-keys M-Right" { if -F "#{pane_at_right}" "" "select-pane -R" }

      bind -T copy-mode-vi "M-Left" if -F "#{pane_at_left}" "" "select-pane -L"
      bind -T copy-mode-vi "M-Down" if -F "#{pane_at_bottom}" "" "select-pane -D"
      bind -T copy-mode-vi "M-Up" if -F "#{pane_at_top}" "" "select-pane -U"
      bind -T copy-mode-vi "M-Right" if -F "#{pane_at_right}" "" "select-pane -R"

      # Resize
      bind -n "M-C-Left" if-shell "$is_vim" "send-keys M-C-Left" "resize-pane -L 1"
      bind -n "M-C-Down" if-shell "$is_vim" "send-keys M-C-Down" "resize-pane -D 1"
      bind -n "M-C-Up" if-shell "$is_vim" "send-keys M-C-Up" "resize-pane -U 1"
      bind -n "M-C-Right" if-shell "$is_vim" "send-keys M-C-Right" "resize-pane -R 1"

      bind -T copy-mode-vi M-C-Left resize-pane -L 1
      bind -T copy-mode-vi M-C-Down resize-pane -D 1
      bind -T copy-mode-vi M-C-Up resize-pane -U 1
      bind -T copy-mode-vi M-C-Right resize-pane -R 1
    '';
  };
}
