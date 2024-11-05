{
  pkgs,
  unstable,
  ...
}: {
  my.shell.bookmarks = [
    {
      path = "~/Darktable Exported";
      binding = "e";
    }
  ];

  home.packages = with pkgs; [
    unstable.darktable
  ];

  xdg.configFile = {
    "darktable/lua/".source = builtins.fetchGit {
      url = "https://github.com/darktable-org/lua-scripts";
      ref = "master";
      rev = "fba639e98a7d7e7a521bcedb4f10c94abf3384bb";
    };
    "darktable/luarc".text = ''
      require "contrib/rename_images"
    '';
  };
}
