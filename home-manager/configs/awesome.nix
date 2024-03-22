{
  pkgs,
  lib,
  ...
}: {
  xsession.windowManager.awesome.enable = true;

  my.shell.bookmarks.a = "~/.config/awesome";

  services.sxhkd = {
    enable = true;
    # TODO: check why don't work
    keybindings = {
      "XF86Audio{Lower,Raise}Volume" = "${lib.getExe pkgs.pamixer} -{d,i} 5";
      "XF86AudioMute" = "${lib.getExe pkgs.pamixer} -t";
    };
  };

  home = {
    packages = [pkgs.sxhkd];

    shellAliases = {
      a = "cd $CONFIG/awesome & $EDITOR rc.lua";
    };
  };
}
