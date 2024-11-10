{
  lib,
  config,
  ...
}: let
  c = config.my.colors;
in {
  programs.starship = {
    enable = false;
    settings = {
      add_newline = true;

      format = lib.concatStrings [
        "$nix_shell"
      ];

      character = {
        success_symbol = "[](bold ${c.accent})";
        error_symbol = "[](bold ${c.red})";
      };

      directory.read_only = " 󰌾";
      hostname.ssh_symbol = " ";

      nix_shell.symbol = " ";
      package.disabled = true;
    };
  };
}
