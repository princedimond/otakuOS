{ inputs, ... }:
{
  flake.modules.nixos.system-workstation = {
    imports = with inputs.self.modules.nixos; [
      system-desktop
      system-workstation
    ];
  };

  flake.modules.homeManager.system-workstation = {
    imports = with inputs.self.modules.homeManager; [
      system-desktop
    ];
  };
}
