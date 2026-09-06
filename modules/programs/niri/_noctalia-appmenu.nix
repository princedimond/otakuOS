{ inputs, ... }:
{
  flake.modules.nixos.niri =
    { ... }:
    {
      services.gnome.at-spi2-core.enable = true;
    };
  flake.modules.homeManager.niri = {
    imports = [
      inputs.noctalia-appmenu.homeManagerModules.default
    ];
    programs.noctalia.plugins.appmenu.enable = true;
  };
}
