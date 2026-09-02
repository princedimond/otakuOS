{ inputs, ... }:
{
  flake.modules.nixos.niri =
    { pkgs, ... }:
    {
      imports = [
        inputs.niri.nixosModules.niri
      ];
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
          common.default = [ "gnome" ];
          common."org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
          common."org.freedesktop.impl.portal.ScreenCast" = [ "wlr" ];
          common."org.freedesktop.impl.portal.Screenshot" = [ "wlr" ];
        };
      };
      programs.niri.enable = true;
    };

}
