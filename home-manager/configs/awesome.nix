{...}: {
  xsession.windowManager.awesome.enable = true;

  my.shell.bookmarks.a = "~/.config/awesome";

  home = {
    shellAliases = {
      a = "cd $CONFIG/awesome & $EDITOR rc.lua";
    };
  };
}
