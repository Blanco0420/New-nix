{
  inputs,
  lib,
  host,
  pkgs,
  config,
  namespace,
  ...
}:
with lib;
let
  cfg = config.apps.firefox;
in
{
  options.apps.firefox = {
    enable = mkEnableOption "enable firefox browser";
  };

  config = mkIf cfg.enable {
    # home.file.".mozilla/firefox/default/chrome/firefox-gnome-theme".source = inputs.firefox-gnome-theme;

    xdg.mimeApps.defaultApplications = {
      "text/html" = [ "firefox.desktop" ];
      "text/xml" = [ "firefox.desktop" ];
      "application/pdf" = [ "firefox.desktop" ];
      "x-scheme-handler/http" = [ "firefox.desktop" ];
      "x-scheme-handler/https" = [ "firefox.desktop" ];
    };

    programs.firefox = {
      enable = true;
      profiles."default" = {
        name = "Default";
        # extraConfig = ''
        #   ${builtins.readFile
        #   "${inputs.firefox-gnome-theme}/configuration/user.js"}
        # '';

        extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
          # gopass-bridge #password manager
          stylus # custom styles
          # temporary-containers #auto delete browsing sessions
          # floccus #bookmark sync
          # languagetool #spelling help
          # plasma-integration # desktop intergration
          # react-devtools #dev tools
          snowflake # help other peeps
          enhanced-github # better gh
          # new-tab-override #start page
          terms-of-service-didnt-read # TOS TLDR
          ublock-origin # ad block

          #yt specific
          enhancer-for-youtube # 1080p 2.5x speed mods
          youtube-recommended-videos # remove yt brain rot
          dearrow # change pics and titles
          sponsorblock # remove yt sponsor spots

          #bullshit removers
          clearurls
          news-feed-eradicator
          # re-enable-right-click
          # absolute-enable-right-click
          ublacklist
          i-dont-care-about-cookies

          #stuff i need to look at later
          #startup-bookmarks
          #markdownload
          #omnivore
          #aria2-integration
        ];

        settings = {
          "browser.uidensity" = 0;
          # "gnomeTheme.activeTabContrast" = true;
          # "gnomeTheme.hideSingleTab" = false;
          # "gnomeTheme.hideWebrtcIndicator" = true;
          # "gnomeTheme.systemIcons" = true;
          # "gnomeTheme.spinner" = true;
          "layers.acceleration.force-enabled" = true;
          "identity.fxaccounts.account.device.name" = "${config.custom.user.name}@${host}";
          "browser.urlbar.oneOffSearches" = false;
          "browser.search.hiddenOneOffs" = "Google,Yahoo,Bing,Amazon.com,Twitter,Wikipedia (en),YouTube,eBay";
          "extensions.pocket.enabled" = false;
          "browser.urlbar.suggest.engines" = false;
          "browser.urlbar.suggest.openpage" = false;
          "browser.urlbar.suggest.bookmark" = false;
          "browser.urlbar.suggest.addons" = false;
          "browser.urlbar.suggest.pocket" = false;
          "browser.urlbar.suggest.topsites" = false;
        };
        # search = {
        #   force = true;
        #   default = "google";
        #   order = ["google" "Youtube" "NixOS Options" "Nix Packages" "GitHub" "HackerNews"];
        #
        #   engines = {
        #     "Bing".metaData.hidden = true;
        #     "eBay".metaData.hidden = true;
        #     "DuckDuckGo".metaData.hidden = true;
        #     "Amazon.com".metaData.hidden = true;
        #     "Wikipedia (en)".metaData.hidden = true;
        #     "YouTube".metaata.hidden = true;
        #     # "google".metaData.hidden = true;
        #     # "Nix Packages".metaData.hidden = true;
        #     # "NixOS Options".metaData.hidden = true;
        #     # "Home Manager".metaData.hidden = true;
        #     # "SourceGraph".metaData.hidden = true;
        #     # "GitHub".metaData.hidden = true;
        #
        #     "google" = {
        #       urls = [
        #         {
        #           template = "https://www.google.co.uk/search";
        #           params = [
        #             {
        #               name = "q";
        #               value = "{searchTerms}";
        #             }
        #           ];
        #         }
        #       ];
        #     };
        #
        #     "YouTube" = {
        #       iconUpdateURL = "https://youtube.com/favicon.ico";
        #       updateInterval = 24 * 60 * 60 * 1000;
        #       definedAliases = ["@yt"];
        #       urls = [
        #         {
        #           template = "https://www.youtube.com/results";
        #           params = [
        #             {
        #               name = "search_query";
        #               value = "{searchTerms}";
        #             }
        #           ];
        #         }
        #       ];
        #     };
        #
        #     "Nix Packages" = {
        #       icon = "https://nixos.org/_astro/flake-blue.Bf2X2kC4_Z1yqDoT.svg";
        #       definedAliases = ["@np"];
        #       urls = [
        #         {
        #           template = "https://search.nixos.org/packages";
        #           params = [
        #             {
        #               name = "type";
        #               value = "packages";
        #             }
        #             {
        #               name = "query";
        #               value = "{searchTerms}";
        #             }
        #             {
        #               name = "channel";
        #               value = "unstable";
        #             }
        #           ];
        #         }
        #       ];
        #     };
        #
        #     "NixOS Options" = {
        #       icon = "https://nixos.org/_astro/flake-blue.Bf2X2kC4_Z1yqDoT.svg";
        #       definedAliases = ["@no"];
        #       urls = [
        #         {
        #           template = "https://search.nixos.org/options";
        #           params = [
        #             {
        #               name = "channel";
        #               value = "unstable";
        #             }
        #             {
        #               name = "query";
        #               value = "{searchTerms}";
        #             }
        #           ];
        #         }
        #       ];
        #     };
        #
        #     "SourceGraph" = {
        #       iconUpdateURL = "https://sourcegraph.com/.assets/img/sourcegraph-mark.svg";
        #       definedAliases = ["@sg"];
        #
        #       urls = [
        #         {
        #           template = "https://sourcegraph.com/search";
        #           params = [
        #             {
        #               name = "q";
        #               value = "{searchTerms}";
        #             }
        #           ];
        #         }
        #       ];
        #     };
        #
        #     "GitHub" = {
        #       iconUpdateURL = "https://github.com/favicon.ico";
        #       updateInterval = 24 * 60 * 60 * 1000;
        #       definedAliases = ["@gh"];
        #
        #       urls = [
        #         {
        #           template = "https://github.com/search";
        #           params = [
        #             {
        #               name = "q";
        #               value = "{searchTerms}";
        #             }
        #           ];
        #         }
        #       ];
        #     };
        #
        #     "Home Manager" = {
        #       # icon = "https://nixos.org/_astro/flake-blue.Bf2X2kC4_Z1yqDoT.svg";
        #       definedAliases = ["@hm"];
        #
        #       url = [
        #         {
        #           template = "https://mipmip.github.io/home-manager-option-search/";
        #           params = [
        #             {
        #               name = "query";
        #               value = "{searchTerms}";
        #             }
        #           ];
        #         }
        #       ];
        #     };
        #   };
        # };

        # :root {{
        #           --gnome-browser-before-load-background:        rgb(30, 30, 46)};
        #           --gnome-accent-bg:                             rgb(137, 180, 250);
        #           --gnome-accent:                                rgb(116, 199, 236);
        #           --gnome-toolbar-background:                    rgb(30, 30, 46);
        #           --gnome-toolbar-color:                         rgb(205, 214, 244);
        #           --gnome-toolbar-icon-fill:                     rgb(205, 214, 244);
        #           --gnome-inactive-toolbar-color:                rgb(30, 30, 46);
        #           --gnome-inactive-toolbar-border-color:         rgb(49, 50, 68);
        #           --gnome-inactive-toolbar-icon-fill:            rgb(205, 214, 244);
        #           --gnome-menu-background:                       rgb(24, 24, 37);
        #           --gnome-headerbar-background:                  rgb(17, 17, 27);
        #           --gnome-button-destructive-action-background:  rgb(237, 135, 150);
        #           --gnome-entry-color:                           rgb(205, 214, 244);
        #           --gnome-inactive-entry-color:                  rgb(205, 214, 244);
        #           --gnome-switch-slider-background:              rgb(24, 24, 37);
        #           --gnome-switch-active-slider-background:       rgb(116, 199, 236);
        #           --gnome-inactive-tabbar-tab-background:        rgb(30, 30, 46);
        #           --gnome-inactive-tabbar-tab-active-background: rgba(255,255,255,0.025);
        #           --gnome-tabbar-tab-background:                 rgb(30, 30, 46);
        #           --gnome-tabbar-tab-hover-background:           rgba(255,255,255,0.025);
        #           --gnome-tabbar-tab-active-background:          rgba(255,255,255,0.075);
        #           --gnome-tabbar-tab-active-hover-background:    rgba(255,255,255,0.100);
        #           --gnome-tabbar-tab-active-background-contrast: rgba(255,255,255,0.125);
        #           }}

        userChrome = ''
          # @import "firefox-gnome-theme/userChrome.css";

          @-moz-document url-prefix(about:home), url-prefix(about:newtab) {{
          body{{
          --newtab-background-color: #2A2A2E!important;
          --newtab-border-primary-color: rgba(249, 249, 250, 0.8)!important;
          --newtab-border-secondary-color: rgba(249, 249, 250, 0.1)!important;
          --newtab-button-primary-color: #0060DF!important;
          --newtab-button-secondary-color: #38383D!important;
          --newtab-element-active-color: rgba(249, 249, 250, 0.2)!important;
          --newtab-element-hover-color: rgba(249, 249, 250, 0.1)!important;
          --newtab-icon-primary-color: rgba(249, 249, 250, 0.8)!important;
          --newtab-icon-secondary-color: rgba(249, 249, 250, 0.4)!important;
          --newtab-icon-tertiary-color: rgba(249, 249, 250, 0.4)!important;
          --newtab-inner-box-shadow-color: rgba(249, 249, 250, 0.2)!important;
          --newtab-link-primary-color: var(--gnome-accent)!important;
          --newtab-link-secondary-color: #50BCB6!important;
          --newtab-text-conditional-color: #F9F9FA!important;
          --newtab-text-primary-color: var(--gnome-accent)!important;
          --newtab-text-secondary-color: rgba(249, 249, 250, 0.8)!important;
          --newtab-textbox-background-color: var(--gnome-toolbar-background)!important;
          --newtab-textbox-border: var(--gnome-inactive-toolbar-border-color)!important;
          --newtab-textbox-focus-color: #45A1FF!important;
          --newtab-textbox-focus-boxshadow: 0 0 0 1px #45A1FF, 0 0 0 4px rgba(69, 161, 255, 0.3)!important;
          --newtab-feed-button-background: #38383D!important;
          --newtab-feed-button-text: #F9F9FA!important;
          --newtab-feed-button-background-faded: rgba(56, 56, 61, 0.6)!important;
          --newtab-feed-button-text-faded: rgba(249, 249, 250, 0)!important;
          --newtab-feed-button-spinner: #D7D7DB!important;
          --newtab-contextmenu-background-color: #4A4A4F!important;
          --newtab-contextmenu-button-color: #2A2A2E!important;
          --newtab-modal-color: #2A2A2E!important;
          --newtab-overlay-color: rgba(12, 12, 13, 0.8)!important;
          --newtab-section-header-text-color: rgba(249, 249, 250, 0.8)!important;
          --newtab-section-navigation-text-color: rgba(249, 249, 250, 0.8)!important;
          --newtab-section-active-contextmenu-color: #FFF!important;
          --newtab-search-border-color: rgba(249, 249, 250, 0.2)!important;
          --newtab-search-dropdown-color: #38383D!important;
          --newtab-search-dropdown-header-color: #4A4A4F!important;
          --newtab-search-header-background-color: rgba(42, 42, 46, 0.95)!important;
          --newtab-search-icon-color: rgba(249, 249, 250, 0.6)!important;
          --newtab-search-wordmark-color: #FFF!important;
          --newtab-topsites-background-color: #38383D!important;
          --newtab-topsites-icon-shadow: none!important;
          --newtab-topsites-label-color: rgba(249, 249, 250, 0.8)!important;
          --newtab-card-active-outline-color: var(--gnome-toolbar-icon-fill)!important;
          --newtab-card-background-color: var(--gnome-toolbar-background)!important;
          --newtab-card-hairline-color: rgba(249, 249, 250, 0.1)!important;
          --newtab-card-placeholder-color: #4A4A4F!important;
          --newtab-card-shadow: 0 1px 8px 0 rgba(12, 12, 13, 0.2)!important;
          --newtab-snippets-background-color: #38383D!important;
          --newtab-snippets-hairline-color: rgba(255, 255, 255, 0.1)!important;
          --trailhead-header-text-color: rgba(255, 255, 255, 0.6)!important;
          --trailhead-cards-background-color: rgba(12, 12, 13, 0.1)!important;
          --trailhead-card-button-background-color: rgba(12, 12, 13, 0.3)!important;
          --trailhead-card-button-background-hover-color: rgba(12, 12, 13, 0.5)!important;
          --trailhead-card-button-background-active-color: rgba(12, 12, 13, 0.7)!important;
        '';

        # userContent = ''
        #   @import "firefox-gnome-theme/userContent.css;
        # '';
      };
    };
  };
}
