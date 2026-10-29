{ inputs, ... }:
{
  flake.modules.nixos.PD-ZENBOOK14X = {

    environment.persistence."/persist" = {
      directories = [
      ];

      users.princedimond = {
        directories = [
          #General Hidden
          ".thunderbird"
          ".ssh"

          #General Main
          #"Code"
          "Desktop"
          "Downloads"
          "Pictures"
          "Music"
          "Videos"

          #.cache
          ".cache/thumbnails"
          ".cache/zen"

          #.local/share
          ".local/share/hyprland"
          ".local/share/icons"
          ".local/share/mime"

          #.local/state
          ".local/state/wireplumber"

          #.config
          ".config/Bitwarden"
          ".config/discord"
          ".config/zen"
          ".config/obs-studio"
        ];

        files = [
          ".local/share/recently-used.xbel" # file manager recently used
          ".local/share/user-places.xbel" # file manager bookmarks
          ".local/share/user-places.xbel.bak"
          ".local/state/lesshst" # history of search for "less"
          ".bash_history"
        ];
      };
    };
  };
}
