{ ... }:
let
  gtk_buttons = "close,minimize,maximize:";
in
{
  flake.modules.nixos.theme-general = {

  };

  flake.modules.homeManager.theme-general = {
    gtk = {
      enable = true;
      gtk3.extraConfig = {
        gtk-decoration-layout = "${gtk_buttons}";
      };
      gtk4.extraConfig = {
        gtk-decoration-layout = "${gtk_buttons}";
      };
    };
    dconf.settings."org/gnome/desktop/wm/preferences".button-layout = "${gtk_buttons}";
  };
}
