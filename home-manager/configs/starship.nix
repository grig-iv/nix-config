{
  lib,
  config,
  ...
}: let
  c = config.my.colors;
in {
  programs.starship = {
    enable = true;
    settings = {
      add_newline = true;

      format = lib.concatStrings [
        "$all"
      ];

      # right_format = lib.concatStrings [
      #   "$git_branch"
      #   "$git_commit"
      #   "$git_state"
      #   "$git_metrics"
      #   "$git_status"
      #   "$line_break"
      #   "$character"
      # ];

      character = {
        success_symbol = "[ඞ](bold ${c.red})";
        error_symbol = "[ඞ](bold ${c.red})";
      };

      directory.read_only = " 󰌾";
      hostname.ssh_symbol = " ";

      git_branch.symbol = " ";
      docker_context.symbol = " ";
      nix_shell.symbol = " ";
      package.disabled = true;

      c = {
        symbol = " ";
      };
      fennel = {
        symbol = " ";
        format = "[$symbol]($style)";
      };
      golang = {
        symbol = " ";
        format = "[$symbol]($style)";
      };
      haskell = {
        symbol = " ";
      };
      lua = {
        symbol = " ";
      };
      nodejs = {
        symbol = " ";
        format = "[$symbol]($style)";
      };
      ocaml = {
        symbol = " ";
        format = "via [$symbol(\($switch_indicator$switch_name\) )]($style)";
      };
      python = {
        symbol = " ";
        format = "[$symbol]($style)";
      };
      rust = {
        symbol = " ";
        format = "[$symbol]($style)";
      };
      scala = {
        symbol = " ";
      };
    };
  };
}
