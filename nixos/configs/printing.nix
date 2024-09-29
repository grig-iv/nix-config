{pkgs, ...}: {
  services = {
    printing = {
      enable = true;
      drivers = with pkgs; [
        gutenprint
      ];
    };
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
  };
}
