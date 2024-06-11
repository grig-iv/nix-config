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
        (name: value: nameValuePair ("g" + name) ("cd " + (lib.escape [" "] value)))
        cfg.bookmarks;

      home.shellAliases =
        lib.mapAttrs'
        (name: value: nameValuePair ("g" + name) ("cd " + (lib.escape [" "] value)))
        cfg.bookmarks;

      programs.yazi.keymap.manager.append_keymap =
        lib.mapAttrsToList
        (name: value: {
          on = ["g" name];
          run = "cd " + (lib.escape [" "] value);
          desc = "Go to " + value;
        })
        (lib.filterAttrs (n: v: n != "h" && n != "c" && n != "d") cfg.bookmarks);
    };
  }
