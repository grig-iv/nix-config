{pkgs, ...}: let
  luafun = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/luafun/luafun/master/fun.lua";
    sha256 = "sha256-tTZLR49n4T25PIkuDhJbvqufkqtZkdICsWQlHnIfCIQ=";
  };
in {
  home.packages = with pkgs; [
    lua
    lua-language-server
    stylua
  ];

  #  home.sessionVariables.LUA_PATH = "${luafun};;";
}
