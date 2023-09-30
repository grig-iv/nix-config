{pkgs, ...}: let
  tmuxRun = pkgs.writeShellScriptBin "tmux-run" ''
    if [ -z "$TMUX" ]; then
        tmux attach -t main || tmux new -s main
    fi
  '';
in {
  programs.tmux = {
    enable = true;
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

      bind c new-window -c "#{pane_current_path}"
      bind | split-window -h -c "#{pane_current_path}"
      bind _ split-window -v -c "#{pane_current_path}"
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
