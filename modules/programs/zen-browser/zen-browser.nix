{ inputs, ... }:
{
  flake.modules.nixos.zen-browser = {
    environment.systemPackages = [
      inputs.zen-browser.packages.x86_64-linux.default
    ];

  };
  flake.modules.homeManager.zen-browser =
    { pkgs, ... }:
    {
      imports = [
        inputs.zen-browser.homeModules.beta
      ];
      nixpkgs.config.allowUnfreePackages = [
        "flagfox"
        "tampermonkey"
      ];
      home.file."catppuccin-zen" = {
        target = ".config/zen/aqua/chrome/catppuccin-zen";
        source = (
          fetchTarball {
            url = "https://github.com/catppuccin/zen-browser/tarball/c855685442c6040c4dda9c8d3ddc7b708de1cbaa";
            sha256 = "sha256:03ky8s5h9vkw4cp3nm86b0bk5qbjmqgyqq9a95xqzard4wppn3p4";
          }
        );
      };
      programs.zen-browser = {
        enable = true;
        policies = {
          AutofillCreditCardEnabled = false;
          DisableAppUpdate = true;
          DisableFeedbackCommands = true;
          DisableFirefoxStudies = true;
          DisablePocket = true;
          DisableTelemetry = true;
          DontCheckDefaultBrowser = true;
          NoDefaultBookmarks = true;
          EnableTrackingProtection = {
            Value = true;
            Locked = true;
            Cryptomining = true;
            Fingerprinting = true;
          };
        };

        profiles.princedimond = {
          settings = {
            "zen.welcome-screen.seen" = true;
            "zen.view.use-single-toolbar" = false;
            "zen.view.show-clear-tabs-button" = false;
            "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
            "browser.shell.checkDefaultBrowser" = false;
            "browser.startup.homepage" = "about:blank";
            "zen.window-sync.enabled" = true;
          };

          search = {
            force = true;
            default = "ddg";
          };

          pinsForce = true;
          spacesForce = true;

          pins = {
            "weather" = {
              id = "b86168a9-aa6c-46d6-ba29-bb5246e5f456";
              url = "https://www.accuweather.com/";
              isEssential = true;
              position = 100;
            };
            "blank" = {
              id = "877a7690-e798-48af-b1c1-fc7d82b69f03";
              url = "about:blank";
              isEssential = true;
              position = 101;
            };
          };

          spaces = {
            "Default" = {
              id = "72fdd687-6673-4248-aab6-4ccafeda8183";
              position = 1000;
            };
            "Funnyjunk" = {
              id = "3bff9140-f9f2-40a2-9e4b-e7b3e591c62c";
              position = 2000;
              icon = "🙂";
            };
            "Youtube" = {
              id = "1b3c04de-bc74-44fb-bcec-ebe1612547f6";
              position = 3000;
              icon = "📺";
            };
            "Music" = {
              id = "c4efba26-2e90-4bdb-b967-45462f722f89";
              position = 4000;
              icon = "🎵";
            };
            "HomeLab" = {
              id = "66ec3411-6854-4208-be68-8975888f26b7";
              position = 5000;
              icon = "💻";
            };
            "AI" = {
              id = "1886d354-6e90-41b6-bfed-a4ea303bcc61";
              position = 6000;
              icon = "🤖";
            };
            "Gaming" = {
              id = "16c036d3-2be0-44b4-b223-c9787ad0fece";
              position = 7000;
              icon = "🎮";
            };
          };

          extensions.packages = with pkgs.nur.repos.rycee.firefox-addons; [
            ublock-origin
            dearrow
            stylus
            bitwarden
            sponsorblock
            darkreader
            clearurls
            flagfox
            privacy-badger
            return-youtube-dislikes
            tampermonkey
            watchmarker-for-youtube
            bandcamp-player-volume-control
          ];

          userChrome = ''
            @import "catppuccin-zen/themes/Mocha/Green/userChrome.css";
          '';
          userContent = ''
            @import "catppuccin-zen/themes/Mocha/Green/userContent.css";
          '';
        };
      };
    };
}
