{
  config,
  inputs,
  unstable,
  ...
}: {
  imports = [inputs.home-manager.nixosModules.home-manager];

  home-manager = {
    backupFileExtension = "backup";
    sharedModules = [inputs.sops-nix.homeManagerModules.sops];
    extraSpecialArgs = {inherit inputs unstable;};
    useGlobalPkgs = true;
    useUserPackages = true;
    users."${config.my.user}" = import (
      ./../../home-manager + "/grig@" + config.my.host + ".nix"
    );
  };
}
