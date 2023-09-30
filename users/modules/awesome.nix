{...}: {
  xsession.enable = true;
  xsession.windowManager.awesome.enable = true;

  home.shellAliases = {
    a = "cd $CONFIG/awesome & e rc.lua";
  };
}
