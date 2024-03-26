{pkgs, ...}: {
  virtualisation.docker.enable = true;
  environment.systemPackages = [pkgs.docker-compose];
  users.extraGroups."docker".members = ["grig"];
}
