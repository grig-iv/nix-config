{
  pkgs,
  lib,
  config,
  ...
}: let
  colors' = config.my.colors';
in {
  imports = [./starship.nix];

  programs.fish = {
    enable = true;
    plugins = with pkgs.fishPlugins; [
      {
        # clear history from typos and private things
        name = "sponge";
        src = sponge.src;
      }
      {
        # "../." auto expands
        name = "puffer";
        src = puffer.src;
      }
      {
        # colored man pages
        name = "colored-man-pages";
        src = colored-man-pages.src;
      }
      {
        name = "nix-env";
        src = pkgs.fetchFromGitHub {
          owner = "lilyball";
          repo = "nix-env.fish";
          rev = "7b65bd228429e852c8fdfa07601159130a818cfa";
          hash = "sha256-RG/0rfhgq6aEKNZ0XwIqOaZ6K5S4+/Y5EEMnIdtfPhk";
        };
      }
    ];

    functions = with lib;
    with pkgs; {
      fish_greeting = "";

      mkdircd = ''
        mkdir -pv $argv; and cd $argv
      '';

      jump = ''
        if test (count $argv) -eq 0
            echo "No target directory provided."
            exit 1
        end

        set target_dir (eval echo $argv[1])
        cd $target_dir; or exit

        set selected_file (${getExe fd} -t f | ${getExe skim} --preview 'bat --color=always --line-range :100 {}')

        if test -n "$selected_file"
            eval $EDITOR $selected_file
        end
      '';

      run = ''
        if test -e "./main.go"
            go run .
        end
      '';
    };

    shellInit = ''
      bind \cq 'exit'
      bind \cl 'clear; commandline -f repaint'
      bind \cr 'run'
    '';

    interactiveShellInit = ''
      set -g fish_color_normal ${colors'.text} # default color
      set -g fish_color_command ${colors'.green} # commands like echo
      set -g fish_color_keyword ${colors'.red} # keywords like if - this falls back on the command color if unset
      set -g fish_color_quote ${colors'.yellow} # quoted text like abc
      set -g fish_color_redirection ${colors'.mauve} # IO redirections like >/dev/null
      set -g fish_color_end ${colors'.peach} # process separators like ; and &
      set -g fish_color_comment ${colors'.overlay0} # comments like ‘# important’
      set -g fish_color_error ${colors'.red} # syntax errors
      set -g fish_color_param ${colors'.peach} # ordinary command parameters
      set -g fish_color_gray ${colors'.overlay0}
      set -g fish_color_selection --background=${colors'.surface0} # selected text in vi visual mode
      set -g fish_color_search_match --background=${colors'.surface0} # history search matches and selected pager items (background only)
      set -g fish_color_option ${colors'.mauve} # options starting with “-”, up to the first “--” parameter
      set -g fish_color_operator ${colors'.pink} # parameter expansion operators like * and ~
      set -g fish_color_escape ${colors'.maroon} # character escapes like \n and \x70
      set -g fish_color_autosuggestion ${colors'.overlay0} # autosuggestions (the proposed rest of a command)
      set -g fish_color_cancel ${colors'.red} # the ‘^C’ indicator on a canceled command
      set -g fish_color_cwd ${colors'.red} # the current working directory in the default prompt
      set -g fish_color_user ${colors'.teal} # the username in the default prompt
      set -g fish_color_host ${colors'.blue} # the hostname in the default prompt
      set -g fish_color_host_remote ${colors'.green} # the hostname in the default prompt for remote sessions (like ssh)
      set -g fish_color_status ${colors'.red} # the last command’s nonzero exit code in the default prompt

      set -g fish_pager_color_progress ${colors'.overlay0} # the progress bar at the bottom left corner
      set -g fish_pager_color_prefix ${colors'.pink} # the prefix string, i.e. the string that is to be completed
      set -g fish_pager_color_completion ${colors'.text} # suffix of the selected completion
      set -g fish_pager_color_description ${colors'.overlay0} # description of the selected completion
    '';
  };

  programs.zoxide.enable = true;
}
