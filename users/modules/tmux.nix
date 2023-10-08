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

      bind r source-file ~/.config/tmux/tmux.conf \; display "Reloaded!"
      bind c new-window -c "#{pane_current_path}"
      bind | split-window -h -c "#{pane_current_path}"
      bind _ split-window -v -c "#{pane_current_path}"

      # Alt bindings
      bind -n M-c new-window -c "#{pane_current_path}"

      bind -n M-h split-window -h -c "#{pane_current_path}"
      bind -n M-v split-window -v -c "#{pane_current_path}"

      bind -n M-C-PgUp previous-window 
      bind -n M-C-PgDn next-window 

      bind -n M-Up select-pane -U
      bind -n M-Down select-pane -D
      bind -n M-Left select-pane -L
      bind -n M-Right select-pane -R
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
