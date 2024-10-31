{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.my.shell;
  bookmarks = pipe cfg.bookmarks [
    (xs: map (x: x.path) xs)
    (xs: concatStringsSep "\n" xs)
    (x: pkgs.writeText "bookmarks" x)
  ];
in
  with lib; {
    options.my.shell.bookmarks = mkOption {
      type = with types; listOf (attrsOf str);
      default = {};
    };

    config = {
      home.shellAliases = mergeAttrsList (
        lib.map
        (x: {"g${x.binding}" = "cd " + (lib.escape [" "] x.path);})
        cfg.bookmarks
      );

      programs.yazi.keymap.manager.prepend_keymap =
        lib.map
        (x: {
          on = ["g" x.binding];
          run = "cd " + (lib.escape [" "] x.path);
          desc = "Go to " + x.path;
        })
        cfg.bookmarks;

      programs.fish.functions.goto_bookmark = ''
        cd $(cat ${bookmarks} | sort -V | ${getExe pkgs.skim})
      '';
    };
  }
