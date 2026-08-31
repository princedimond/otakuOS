{ ... }:
{
  flake.modules.nixos.catppuccin-gui =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        libsForQt5.qtstyleplugin-kvantum
        libsForQt5.qt5ct
        catppuccin-kvantum
        magnetic-catppuccin-gtk
      ];

      environment.variables.QT_QPA_PLATFORMTHEME = "qt5ct";
    };

  flake.modules.homeManager.catppuccin-gui =
    { pkgs, ... }:
    {
      catppuccin = {
        cursors.enable = true;
      };

      gtk = {
        enable = true;
        theme = {
          name = "Catppuccin-GTK-Dark";
          package = pkgs.magnetic-catppuccin-gtk;
        };
      };

      qt = {
        enable = true;
        platformTheme.name = "qtct";
        style.name = "kvantum";
      };
    };
}
