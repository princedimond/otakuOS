{ ... }:
{
  flake.modules.nixos.princedimond-gui =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        gedit
      ];
    };

  flake.modules.homeManager.princedimond-gui =
    { pkgs, ... }:
    {

      home.file.".local/share/libgedit-gtksourceview-300/styles/catppuccin-mocha.xml".source =
        pkgs.fetchurl
          {
            url = "https://raw.githubusercontent.com/catppuccin/gedit/refs/heads/main/themes/catppuccin-mocha.xml";
            hash = "sha256-+Ew1IR0GjGSJJUOe4DOws+V2AtvojG+zUfXI9ZD7CAE=";
          };

      dconf.settings = {
        "org/gnome/gedit/preferences/editor" = {
          scheme = "catppuccin-mocha";
        };
      };
    };
}
