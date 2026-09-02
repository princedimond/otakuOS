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
        ];
        config = {
          common.default = [ "gnome" ];
          common."org.freedesktop.impl.portal.FileChooser" = [ "gtk" ];
        };
      };
      programs.niri.enable = true;
    };

}
