{ inputs, ... }:
{
  flake.modules.nixos.niri =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        xwayland-satellite
      ];
      xdg.portal = {
        enable = true;
        xdgOpenUsePortal = true;
        extraPortals = [
          pkgs.xdg-desktop-portal-gtk
          pkgs.xdg-desktop-portal-gnome
          pkgs.xdg-desktop-portal-wlr
        ];
        config = {
          common = {
            default = [
              "gnome"
              "gtk"
            ];
            "org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
          };
          niri = {
            default = [
              "gnome"
              "gtk"
            ];
            "org.freedesktop.impl.portal.ScreenCast" = [ "wlr" ];
            "org.freedesktop.impl.portal.Screenshot" = [ "wlr" ];
          };
        };
      };
      programs.niri.enable = true;
    };

}
