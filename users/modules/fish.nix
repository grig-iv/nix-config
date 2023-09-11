{
  config,
  pkgs,
  lib,
  ...
}: let
  colors = config.my.colors.base16;
in {
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
    ];

    shellAliases = {
      # Verbosity and settings that you pretty much just always are going to want.
      cp = "cp -ivr";
      mv = "mv -iv";
      rm = "rm -vI";
      mkd = "mkdir -pv";

      # Colorize commands when possible.
      ls = "exa --icons";
      grep = "grep --color=auto";
      diff = "diff --color=auto";
      ccat = "highlight --out-format=ansi";
      ip = "ip -color=auto";

      # These common commands are just too long! Abbreviate them.
      g = "git";
      e = "$EDITOR";
      ef = "nix run $NVIMCONF";

      # Edit shortcuts
      enx = "cd $NIXCONF & e";
      env = "cd $NVIMCONF & e";

      # nix
      nft = "nix fmt";
      rshm = "home-manager switch --flake $NIXCONF#${config.home.username}";
      rsnc = "sudo nixos-rebuild switch --flake $NIXCONF#nixos";

      vpn-on = "wg-quick up $CONFIG/wireguard/peer.conf";
      vpn-off = "wg-quick down $CONFIG/wireguard/peer.conf";
      find-font = "fc-list | grep ";
    };

    shellInit = ''
      zoxide init fish | source

      function fish_prompt
          set_color -o a6e3a1
          echo -n (prompt_pwd)
          echo -n ' '
          set_color f38ba8
          echo -n 'ඞ '
          set_color normal
      end

      set --universal fish_color_normal cdd6f4
      set --universal fish_color_command 89b4fa
      set --universal fish_color_param f2cdcd
      set --universal fish_color_keyword f38ba8
      set --universal fish_color_quote a6e3a1
      set --universal fish_color_redirection f5c2e7
      set --universal fish_color_end fab387
      set --universal fish_color_comment 7f849c
      set --universal fish_color_error f38ba8
      set --universal fish_color_gray 6c7086
      set --universal fish_color_selection --background=313244
      set --universal fish_color_search_match --background=313244
      set --universal fish_color_option a6e3a1
      set --universal fish_color_operator f5c2e7
      set --universal fish_color_escape eba0ac
      set --universal fish_color_autosuggestion 6c7086
      set --universal fish_color_cancel f38ba8
      set --universal fish_color_cwd f9e2af
      set --universal fish_color_user 94e2d5
      set --universal fish_color_host 89b4fa
      set --universal fish_color_host_remote a6e3a1
      set --universal fish_color_status f38ba8
      set --universal fish_pager_color_progress 6c7086
      set --universal fish_pager_color_prefix f5c2e7
      set --universal fish_pager_color_completion cdd6f4
      set --universal fish_pager_color_description 6c7086
    '';
  };

  home.packages = with pkgs; [
    zoxide
    fzf
  ];
}
