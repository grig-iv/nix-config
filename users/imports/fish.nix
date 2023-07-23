{
  config,
  pkgs,
  ...
}: let
  colors = config.my.colors.base16;
in {
  programs.fish = {
    enable = true;
    plugins = with pkgs.fishPlugins; [
      # colorized command output
      {
        name = "grc";
        src = grc.src;
      }
      # faster dir jumps
      {
        name = "z";
        src = z.src;
      }
      # clear history from typos and private things
      {
        name = "sponge";
        src = sponge.src;
      }
      # "../." auto expands
      {
        name = "puffer";
        src = puffer.src;
      }
      # colored man pages
      {
        name = "colored-man-pages";
        src = colored-man-pages.src;
      }
    ];

    shellAliases = {
      # Verbosity and settings that you pretty much just always are going to want.
      cp = "cp -ivr";
      mv = "mv -iv";
      rm = "rm -vI";
      mkd = "mkdir -pv";

      # Colorize commands when possible.
      ls = "ls -hN --color=auto --group-directories-first";
      grep = "grep --color=auto";
      diff = "diff --color=auto";
      ccat = "highlight --out-format=ansi";
      ip = "ip -color=auto";

      # These common commands are just too long! Abbreviate them.
      g = "git";
      e = "$EDITOR";
      ef = "nix run ~/.config/neovim-flake";
      shdn = "shutdown -h now";

      # Edit shortcuts
      enx = "cd /etc/nixos & e";
      env = "cd $CONFIG/neovim-flake & e";

      # Shortcuts
      shutdown = "sudo shutdown";
      reboot = "sudo reboot";

      # nix
      nft = "nix fmt";
      rshm = "home-manager switch --flake /etc/nixos#${config.home.username}";
      rsnc = "sudo nixos-rebuild switch --flake /etc/nixos#nixos";

      vpn-on = "wg-quick up $CONFIG/wireguard/peer.conf";
      vpn-off = "wg-quick down $CONFIG/wireguard/peer.conf";
      find-font = "fc-list | grep ";
    };

    shellInit = ''
      fish_vi_key_bindings

      function fish_prompt
          set_color -o ${colors.base0E}
          echo -n '['
          set_color ${colors.base05}
          echo -n (whoami)
          echo -n ' '
          set_color -o ${colors.base09}
          echo -n (prompt_pwd)
          set_color ${colors.base0E}
          echo -n '] '
          set_color red
          echo -n 'ඞ '
          set_color normal
      end

      set --universal fish_color_autosuggestion ${colors.base03} # autosuggestions
      set --universal fish_color_command        ${colors.base0E} # commands
      set --universal fish_color_comment        ${colors.base03} # code comments
      set --universal fish_color_quote          ${colors.base0B} # ayu:syntax.string    quoted blocks of text
      set --universal fish_color_escape         ${colors.base0C} # ayu:syntax.regexp    highlight character escapes like '\n' and '\x70'
      set --universal fish_color_end            ${colors.base05} # ayu:syntax.operator  process separators like ';' and '&'
      set --universal fish_color_redirection    ${colors.base09} # ayu:syntax.constant  IO redirections
      #set --universal fish_color_normal         FF0000 # ayu:common.fg        default color
      #set --universal fish_color_cwd            59C2FF # ayu:syntax.entity    current working directory in the default prompt
      #set --universal fish_color_error          FF3333 # ayu:syntax.error     highlight potential errors
      #set --universal fish_color_match          F07178 # ayu:syntax.markup    highlight matching parenthesis
      #set --universal fish_color_operator       E6B450 # ayu:syntax.accent    parameter expansion operators like '*' and '~'
      #set --universal fish_color_param          B3B1AD # ayu:common.fg        regular command parameters
      #set --universal fish_color_search_match   --background E6B450 # ayu:syntax.accent    highlight history search matches and the selected pager item (must be a background)
      #set --universal fish_color_selection      E6B450 # ayu:syntax.accent    when selecting text (in vi visual mode)
    '';
  };
}
