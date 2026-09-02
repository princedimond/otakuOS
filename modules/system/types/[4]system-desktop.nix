{ inputs, ... }:
{
  flake.modules.nixos.system-desktop = {
    imports = with inputs.self.modules.nixos; [
      system-cli
      niri
      catppuccin-gui
      princedimond-gui
      zen-browser
    ];
  };

  flake.modules.homeManager.system-desktop = {
    imports = with inputs.self.modules.homeManager; [
      system-cli
      catppuccin-gui
      niri
    ];
  };
}
