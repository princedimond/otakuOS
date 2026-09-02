{ inputs, ... }:
{
  flake.modules.nixos.system-gaming = {
    imports = with inputs.self.modules.nixos; [
      system-desktop
      princedimond-gaming
    ];
  };

  flake.modules.homeManager.system-gaming = {
    imports = with inputs.self.modules.homeManager; [
      system-desktop
      princedimond-gaming
    ];
  };
}
