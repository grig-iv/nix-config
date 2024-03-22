{pkgs, ...}: {
  home.packages = [pkgs.sxiv];

  xdg = {
    mimeApps = {
      enable = true;
      defaultApplications = {
        "image/png" = "sxiv.desktop";
        "image/bmp" = "sxiv.desktop";
        "image/gif" = "sxiv.desktop";
        "image/jpeg" = "sxiv.desktop";
      };
    };
  };
}
