{
  pkgs,
  lib,
  config,
  ...
}: let
  c = config.my.colors;

  activeWindow = lib.concatStrings [
    "#[fg=${c.surface0},bg=default]"
    "#[fg=${c.primary},bg=${c.surface0},bold]#{b:pane_current_path}"
    "#[fg=${c.surface0},bg=default]"
  ];

  inactiveWindow = lib.concatStrings [
    "#[fg=${c.subtext0}] #{b:pane_current_path} "
  ];

  statusLeft = lib.concatStrings [
    "#[fg=${c.accent}]#{pane_current_path}"
  ];

  statusRight = lib.concatStrings [
    "#[fg=${c.primary}]#{session_name}  "
  ];
in {
  programs.tmux = {
    enable = true;
    prefix = "M-b";
    escapeTime = 50;
    baseIndex = 1;
    keyMode = "vi";
    newSession = true;
    mouse = true;
    terminal = "tmux-256color";
    shell = lib.getExe pkgs.zsh;
    extraConfig = ''
      set -sa terminal-overrides ",xterm*:Tc"

      # theme
      set -g status-position top
      set -g status-style bg=default
      set -g status-justify absolute-centre
      set -g window-status-format "${inactiveWindow}"
      set -g window-status-separator ""
      set -g window-status-current-format "${activeWindow}"
      set -g status-left "${statusLeft}"
      set -g status-right "${statusRight}"
      set -g status-left-length 65
      set -g pane-active-border-style fg=${c.primary}
      set -g pane-border-style fg=${c.overlay0}
      set -g message-style fg=${c.accent},bg=default
      set -g message-command-style fg=${c.accent},bg=default

      bind -n M-F5 source-file ~/.config/tmux/tmux.conf \; display "Reloaded!"

      # Tmux only bindings
      bind -n M-n new-window -c "#{pane_current_path}"
      bind -n M-q confirm-before -p "kill-window #W? (y/n)" kill-pane
      bind q confirm-before -p "kill-server #W? (y/n)" kill-server

      bind -n M-h split-window -h -c "#{pane_current_path}"
      bind -n M-v split-window -v -c "#{pane_current_path}"

      bind -n M-C-PgUp previous-window
      bind -n M-C-PgDn next-window

      bind -n M-C-S-PgUp switch-client -p
      bind -n M-C-S-PgDn switch-client -n

      bind -r S-Up swap-pane -U
      bind -r S-Down swap-pane -D

      bind -n M-s display-popup -E "nvim /tmp/scratchpad.md"
      bind -n M-m display-popup -w 80% -h 80% -E "nvim '$HOME/Extended Mind/context.md'"
      bind -n M-g display-popup -w 80% -h 80% -d "#{pane_current_path}" -E "lazygit"
      bind -n M-t display-popup -d "#{pane_current_path}" -E "fish"

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
      bind -n "M-C-Left" if-shell "$is_vim" "send-keys M-C-Left" "resize-pane -L 5"
      bind -n "M-C-Down" if-shell "$is_vim" "send-keys M-C-Down" "resize-pane -D 5"
      bind -n "M-C-Up" if-shell "$is_vim" "send-keys M-C-Up" "resize-pane -U 5"
      bind -n "M-C-Right" if-shell "$is_vim" "send-keys M-C-Right" "resize-pane -R 5"

      bind -T copy-mode-vi M-C-Left resize-pane -L 1
      bind -T copy-mode-vi M-C-Down resize-pane -D 1
      bind -T copy-mode-vi M-C-Up resize-pane -U 1
      bind -T copy-mode-vi M-C-Right resize-pane -R 1
    '';
  };
}
