{...}: {
  xsession.windowManager.awesome.enable = true;

  # TODO - download the font into $XDG_DATA_HOME/fonts
  # https://www.dafont.com/gameplay.font

  home = {
    shellAliases = {
      a = "cd $CONFIG/awesome & e rc.lua";
      ga = "cd $CONFIG/awesome";
    };
  };
}
