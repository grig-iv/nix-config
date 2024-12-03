{
  unstable,
  pkgs,
  ...
}: {
  services = {
    printing = {
      enable = true;
      package = unstable.cups;
      drivers = with pkgs; [
        gutenprint
      ];
    };
    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
    };
    ipp-usb.enable = true;
  };
}
