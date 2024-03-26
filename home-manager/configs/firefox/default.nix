{pkgs, ...}: {
  home.sessionVariables.BROWSER = "firefox";

  xdg = {
    configFile."tridactyl/tridactylrc".source = ./tridactylrc;
    mimeApps = {
      enable = true;
      defaultApplications = {
        "x-scheme-handler/http" = "firefox.desktop";
        "x-scheme-handler/https" = "firefox.desktop";
      };
    };
  };

  programs.firefox = {
    enable = true;
    package = pkgs.firefox.override {
      cfg.nativeMessagingHosts.packages = [pkgs.tridactyl-native];
    };

    profiles.default = {
      id = 0;
      isDefault = true;
      name = "Grig";

      # https://github.com/nix-community/nur-combined/blob/master/repos/rycee/pkgs/firefox-addons/generated-firefox-addons.nix
      extensions = with pkgs.nur.repos.rycee.firefox-addons;
        [
          firefox-color # color-scheme https://github.com/catppuccin/firefox
          stylus # sites color-scheme https://github.com/catppuccin/userstyles
          ublock-origin # adblocker
          tridactyl # vim motions
          bitwarden # password manager
          i-dont-care-about-cookies # cookies popup disabler
          libredirect # redirect to freetube
          clearurls # remove tracking part of urls
          no-pdf-download # disable auto download for some pdfs
          decentraleyes # local js libraries, instead of Google Hosted Libraries
          foxyproxy-standard # proxy managemnt tool
        ]
        ++ (with pkgs.nur.repos.bandithedoge.firefoxAddons; [
          material-icons-for-github # material icons for github
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

      settings = {
        # general settings
        "app.update.auto" = false; # disable autoupdate
        "toolkit.legacyUserProfileCustomizations.stylesheets" = true; # enable userChrome
        "dom.webnotifications.enabled" = false; # block site notifications
        "signon.rememberSignons" = false; # remembe passwords
        "geo.enabled" = false; # disable geolocation
        "full-screen-api.warning.timeout" = 0; # disable full screen warning
        "media.videocontrols.picture-in-picture.video-toggle.enabled" = false; # disable picture-in-pictur feature
        "layers.acceleration.force-enabled" = true; # should help with screen tearing
        "extensions.pocket.enabled" = false; # disable pocket
        "extensions.activeThemeID" = "firefox-compact-dark@mozilla.org"; # default theme
        "extensions.update.autoUpdateDefault" = false;
        "extensions.update.enabled" = false;
        "browser.shell.checkDefaultBrowser" = false;
        "browser.tabs.firefox-view" = false; # disable firefox view
        "browser.aboutConfig.showWarning" = false; # disable about:config warning
        "browser.ctrlTab.sortByRecentlyUsed" = true; # <C-Tab> to prev tab
        "browser.download.dir" = "~/downloads"; # set downloads directory
        "browser.uidensity" = 1; # compact view
        "browser.toolbars.bookmarks.visibility" = "never"; # doesn't show bookmark bar
        "browser.startup.page" = 3; # restore previous tabs on startup
        "browser.translations.neverTranslateLanguages" = "ru"; # do not translate ru pages
        "browser.download.autohideButton" = false;
        "widget.use-xdg-desktop-portal.file-picker" = 2;
        "widget.use-xdg-desktop-portal.mime-handler" = 2;
        "xpinstall.signatures.required" = false; # for bypass-payawlls

        # search bar = {
        "browser.urlbar.suggest.quicksuggest.sponsored" = false;
        "browser.urlbar.suggest.quicksuggest.nonsponsored" = false;
        "browser.newtabpage.activity-stream.improvesearch.topSiteSearchShorcuts" = false;
        "browser.urlbar.showSearchSuggestionsFirst" = false;

        # graphics
        "media.ffmpeg.vaapi.enabled" = true;
        "media.gpu-process-decoder" = true;
        "dom.webgpu.enabled" = true;
        "gfx.webrender.all" = true;
        "layers.mlgpu.enabled" = true;
        "layers.gpu-process.enabled" = true;
        "webgl.disabled" = false; # for shadertoy

        # disable telemetry settings
        "toolkit.telemetry.enabled" = false;
        "toolkit.telemetry.server" = "";
        "toolkit.telemetry.archive.enabled" = false;
        "toolkit.telemetry.newProfilePing.enabled" = false;
        "toolkit.telemetry.updatePing.enabled" = false;
        "toolkit.telemetry.bhrPing.enabled" = false;
        "toolkit.telemetry.firstShutdownPing.enabled" = false;
        "datareporting.healthreport.uploadEnabled" = false;
        "datareporting.policy.dataSubmissionEnabled" = false;
        "browser.newtabpage.activity-stream.telemetry" = false;
        "browser.newtabpage.activity-stream.feeds.telemetry" = false;
        "browser.ping-centre.telemetry" = false;
        "toolkit.telemetry.reportingpolicy.firstRun" = false;
        "toolkit.telemetry.unified" = false;
        "toolkit.telemetry.shutdownPingSender.enabled" = false;
        "security.protectionspopup.recordEventTelemetry" = false;
        "security.identitypopup.recordEventTelemetry" = false;
        "security.certerrors.recordEventTelemetry" = false;
        "security.app_menu.recordEventTelemetry" = false;
        "toolkit.telemetry.pioneer-new-studies-available" = false;
        "app.shield.optoutstudies.enable" = false;

        # privacy settings
        "privacy.firstparty.isolate" = true; # prevent cookies and web data from being shared between domains
        "privacy.donottrackheader.enabled" = true; # enable the Do Not Track header
        "media.navigator.enabled" = false; # prevent websites from accessing your device's microphone and camera
        "media.peerconnection.enabled" = false; # disable WebRTC to prevent potential IP leaks
        "network.cookie.cookieBehavior" = 1; # allow cookies from originating sites only (block third-party cookies)
        "network.dns.disablePrefetch" = true; # prevent Firefox from "prefetching" DNS requests
        "network.predictor.enabled" = false; # disable network prediction
        "network.http.referer.XOriginPolicy" = 2; # only send the referrer header with the origin when the origins will be same
        "network.http.referer.XOriginTrimmingPolicy" = 2; # when sending the referrer across origins, send only the origin, not the full URL
        # "privacy.resistFingerprinting" = true; # make Firefox more resistant to browser fingerprinting | dns-shop.ru dosen't work with this one on
        # "network.http.referer.trimmingPolicy" = 2; # send only the origin as a referrer instead of the full URL | gpt-4 dosent' work with this
        "dom.battery.enabled" = false;
      };
    };
  };
}
