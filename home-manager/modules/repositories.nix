{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  repos = config.my.repositories;
  script =
    concatMapStrings (r: ''
      if [ ! -e ${r.path} ]; then
          mkdir -p ${dirOf r.path}
          GIT_SSH=${getExe pkgs.openssh} ${getExe pkgs.git} clone ${r.url} ${r.path}
      fi
    '')
    repos;
in {
  options.my.repositories = mkOption {
    type = types.listOf (types.attrsOf types.str);
    default = [];
    description = "Repositories to clone";
  };

  config = {
    home.activation.git-cloning = hm.dag.entryAfter ["writeBoundary"] script;
  };
}
