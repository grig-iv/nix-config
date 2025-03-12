{
  pkgs,
  config,
  ...
}: {
  programs.fish.enable = true;
  programs.zsh.enable = true;
  users.users."${config.my.user}" = {
    isNormalUser = true;
    initialPassword = config.my.user;
    description = "Grig";
    shell = pkgs.zsh;
    extraGroups = ["wheel"];
  };
}
