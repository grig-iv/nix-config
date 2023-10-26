{pkgs, ...}: {
  home.sessionVariables."BROWSER" = "firefox";

  programs.firefox = {
    enable = true;
    package = pkgs.firefox.override {cfg.enableTridactylNative = true;};

    profiles.default = {
      id = 0;
      isDefault = true;
      name = "Grig";

      # https://github.com/nix-community/nur-combined/blob/master/repos/rycee/pkgs/firefox-addons/generated-firefox-addons.nix
      extensions = with pkgs.nur.repos.rycee.firefox-addons;
        [
          ublock-origin
          tridactyl
          bitwarden
          i-dont-care-about-cookies
          firefox-color # https://github.com/catppuccin/firefox
          improved-tube
          buster-captcha-solver
          clearurls
          no-pdf-download
          decentraleyes
          stylus
        ]
        ++ (with pkgs.nur.repos.bandithedoge.firefoxAddons; [
          material-icons-for-github
        ]);

      # TODO add real bookmarks
      bookmarks = [
        {
          name = "wikipedia";
          tags = ["wiki"];
          keyword = "wiki";
          url = "https://en.wikipedia.org/wiki/Special:Search?search=%s&go=Go";
        }
        {
          name = "kernel.org";
          url = "https://www.kernel.org";
        }
        {
          name = "Nix sites";
          toolbar = true;
          bookmarks = [
            {
              name = "homepage";
              url = "https://nixos.org/";
            }
            {
              name = "wiki";
              tags = ["wiki" "nix"];
              url = "https://nixos.wiki/";
            }
          ];
        }
      ];

      userChrome = ''
        #TabsToolbar {
          visibility: collapse;
        }

        #navigator-toolbox:hover #TabsToolbar,
        #navigator-toolbox:active #TabsToolbar {
          visibility: visible;
        }
      '';

      settings = {
        "app.update.auto" = false; # disable autoupdate
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true; # enable userChrome
        "extensions.pocket.enabled" = false; # disable pocket
        "dom.webnotifications.enabled" = false; # block site notifications
        "signon.rememberSignons" = false; # remembe passwords
        "geo.enabled" = false; # disable geolocation
        "browser.tabs.firefox-view" = false; # disable firefox view
        "browser.aboutConfig.showWarning" = false; # disable about:config warning
        "browser.ctrlTab.sortByRecentlyUsed" = true; # <C-Tab> to prev tab
        "full-screen-api.warning.timeout" = 0; # disable full screen warning
        "browser.download.dir" = "~/downloads"; # set downloads directory
        "media.videocontrols.picture-in-picture.video-toggle.enabled" = false; # disable picture-in-pictur feature
        "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org"; # default theme
        "browser.uidensity" = 1; # compact view
        "browser.toolbars.bookmarks.visibility" = "never"; # doesn't show bookmark bar
        "browser.urlbar.showSearchSuggestionsFirst" = false; # search engien suggestion goes after history/bookmarks suggestions
        "browser.startup.page" = 3; # restore previous tabs on startup
        "browser.translations.neverTranslateLanguages" = "ru"; # do not translate ru pages

        # disable telemetry settings
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.server" = "";
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.updatePing.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;

        # Additional privacy settings
        "privacy.resistFingerprinting" = true; # make Firefox more resistant to browser fingerprinting
        "privacy.firstparty.isolate" = true; # prevent cookies and web data from being shared between domains
        "network.cookie.cookieBehavior" = 1; # allow cookies from originating sites only (block third-party cookies)
        "media.navigator.enabled" = false; # prevent websites from accessing your device's microphone and camera
        "network.dns.disablePrefetch" = true; # prevent Firefox from "prefetching" DNS requests
        "network.predictor.enabled" = false; # disable network prediction
        "webgl.disabled" = true; # disable WebGL which can be used to fingerprint your device
        "media.peerconnection.enabled" = false; # disable WebRTC to prevent potential IP leaks
        "network.http.referer.trimmingPolicy" = 2; # send only the origin as a referrer instead of the full URL
        "network.http.referer.XOriginPolicy" = 2; # only send the referrer header with the origin when the origins will be same
        "network.http.referer.XOriginTrimmingPolicy" = 2; # when sending the referrer across origins, send only the origin, not the full URL
        "privacy.donottrackheader.enabled" = true; # enable the Do Not Track header
      };
    };
  };

  xdg.configFile."tridactyl/tridactylrc".text = ''
    bind <F14> back
    bind <F17> forward
    bind --mode=ex <ArrowUp> ex.prev_completion
    bind --mode=ex <ArrowDown> ex.next_completion
  '';
}
