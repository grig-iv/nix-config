{
  pkgs,
  config,
  lib,
  ...
}:
with lib; let
  repos = config.my.repositories;
  script =
    concatMapStrings (r: let
      ssh = getExe pkgs.openssh;
      git = getExe pkgs.git;
      options =
        if r ? options
        then r.options
        else "";
    in ''
      if [ ! -e ${r.path} ]; then
          mkdir -p ${dirOf r.path}
          GIT_SSH=${ssh} ${git} clone ${options} ${r.url} ${r.path}
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
