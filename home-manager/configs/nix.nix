{pkgs, ...}: {
  manual = {
    html.enable = false;
    json.enable = false;
    manpages.enable = false;
  };

  home = {
    packages = with pkgs; [
      alejandra
      nil
    ];
  };

  systemd.user.startServices = "sd-switch";
}
