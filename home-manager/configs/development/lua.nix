{pkgs, ...}: let
  luafun = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/luafun/luafun/cc118e135b8dc3c8b5a2292394b2397506ff0e22/fun.lua";
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
