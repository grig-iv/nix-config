{pkgs, ...}: {
  home.packages = with pkgs; [
    gnome-extension-manager
    gnomeExtensions.blur-my-shell
    gnomeExtensions.vitals
    gnomeExtensions.openweather
    gnomeExtensions.removable-drive-menu
    gnomeExtensions.user-themes
  ];

  dconf = {
    enable = true;
    settings = {
      "org/gnome/shell" = {
        favorite-apps = [
          "org.telegram.desktop.desktop"
          "discord.desktop"
          "firefox.deskto"
          "Alacritty.deskt"
        ];

        disable-user-extensions = false;
        enabled-extensions = [
          "blur-my-shell@aunetx"
          "Vitals@CoreCoding.com"
          "openweather-extension@jenslody.de"
          "drive-menu@gnome-shell-extensions.gcampax.github.com"

          "auto-move-windows@gnome-shell-extensions.gcampax.github.com"
          "launch-new-instance@gnome-shell-extensions.gcampax.github.com"
          "native-window-placement@gnome-shell-extensions.gcampax.github.com"
          "user-theme@gnome-shell-extensions.gcampax.github.com"
        ];
      };

      "/org/gnome/shell/extensions/blur-my-shell" = {
        noise-amount = "0.80";
        noise-lightness = "0.80";
      };

      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };

      "/org/gnome/mutter" = {
        edge-tiling = true;
      };
    };
  };
}
