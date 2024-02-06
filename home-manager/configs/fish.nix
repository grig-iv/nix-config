{
  config,
  pkgs,
  lib,
  ...
}: let
  # Setup script for a non-nixos system
  fishSetup = pkgs.writeShellScriptBin "fish-setup" ''
    if [[ $EUID -ne 0 ]]; then
        echo "This script must be run as root."
        exit 1
    fi

    if ! grep -q "${pkgs.fish}/bin/fish" /etc/shells; then
        echo "${pkgs.fish}/bin/fish" | sudo tee -a /etc/shells
    fi

    # Change the shell to fish
    chsh -s "${pkgs.fish}/bin/fish" ${config.home.username}
  '';
in {
  home.packages = [
    fishSetup
  ];

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
      fish_prompt = ''
        set_color -o a6e3a1
        echo -n (prompt_pwd)
        echo -n ' '
        set_color f38ba8
        echo -n 'ඞ '
        set_color normal
      '';

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
    };

    shellInit = ''
      bind \cq 'exit'
      bind \cl 'clear; commandline -f repaint'
    '';

    interactiveShellInit = ''
      if not set -q CATPPUCCIN_MOCHA_THEME_SET
          fish_config theme save "Catppuccin Mocha"
          set -U CATPPUCCIN_MOCHA_THEME_SET yes
      end
    '';
  };

  xdg.configFile."fish/themes/Catppuccin Mocha.theme".source = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/catppuccin/fish/main/themes/Catppuccin%20Mocha.theme";
    sha256 = "MlI9Bg4z6uGWnuKQcZoSxPEsat9vfi5O1NkeYFaEb2I=";
  };

  programs.zoxide.enable = true;
}
