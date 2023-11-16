{pkgs, ...}: {
  imports = [./lua.nix];
  home.packages = with pkgs; [
    luajitPackages.fennel
    nur.repos.bandithedoge.fennel-language-server
    fnlfmt
  ];
}
