{
  config,
  lib,
  ...
}: let
  cfg = config.my.shell;
in
  with lib; {
    options.my.shell.bookmarks = mkOption {
      type = with types; attrsOf str;
      default = {};
    };

    config = {
      programs.lf.keybindings =
        lib.mapAttrs'
        (name: value: nameValuePair ("g" + name) ("cd " + value))
        cfg.bookmarks;

      home.shellAliases =
        lib.mapAttrs'
        (name: value: nameValuePair ("g" + name) ("cd " + value))
        cfg.bookmarks;
    };
  }
