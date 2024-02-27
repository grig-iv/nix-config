{pkgs, ...}: {
  xsession.windowManager.awesome.enable = true;

  my.shell.bookmarks.a = "~/.config/awesome";

  services.sxhkd.enable = true;

  home = {
    packages = [pkgs.sxhkd];

    shellAliases = {
      a = "cd $CONFIG/awesome & $EDITOR rc.lua";
    };
  };
}
