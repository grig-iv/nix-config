{
  pkgs,
  lib,
  ...
}:
with lib; {
  imports = [
    ./../../modules
  ];

  xdg.enable = true;

  my.shell.bookmarks = [
    {
      path = "~/";
      binding = "h";
    }
  ];

  home = {
    # FIXME
    username = lib.mkDefault "grig";
    homeDirectory = lib.mkDefault "/home/grig";

    packages = with pkgs; [
      bottom
      wget
      curl
      unzip
      tldr
      zip
      tree
      bc
    ];

    sessionVariables = {
      CONFIG = mkDefault "$HOME/.config";
    };

    sessionPath = [
      "$HOME/.local/bin"
    ];

    shellAliases = {
      # Verbosity and settings that you pretty much just always are going to want.
      cp = "cp -ivr";
      mv = "mv -iv";
      rm = "rm -vI";
      mkdir = "mkdir -pv";
      bc = "bc -ql";

      # Colorize commands when possible.
      grep = "grep --color=auto";
      diff = "diff --color=auto";
      ccat = "highlight --out-format=ansi";
      ip = "ip -color=auto";
    };
  };
}
