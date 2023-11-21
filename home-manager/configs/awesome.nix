{config, ...}: {
  xsession.windowManager.awesome.enable = true;

  my.shell.bookmarks.a = "~/.config/awesome";

  home = {
    shellAliases = {
      a = "cd $CONFIG/awesome & e rc.lua";
    };
  };
}
