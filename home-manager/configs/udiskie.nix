{config, ...}: {
  # Reqired in nixos: services.udisks2.enable = true;
  services.udiskie = {
    enable = true;
    tray = "never";
  };

  my.shell.bookmarks = {
    pa = "~/my-passport/Anime";
    pm = "~/my-passport/Movies";
    ps = "~/my-passport/Serials";
  };

  home.activation.createMyPassportLink = config.lib.dag.entryAfter ["writeBoundary"] ''
    ln -sfn "/run/media/${config.home.username}/My Passport" "$HOME/my-passport"
  '';
}
