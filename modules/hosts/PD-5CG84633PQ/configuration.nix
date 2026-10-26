{ inputs, ... }:
{
  flake.modules.nixos.PD-5CG84633PQ = {
    networking.hostName = "PD-5CG84633PQ";

    imports = with inputs.self.modules.nixos; [
      system-desktop
      intelcpu
      installer-iso-keys
    ];

    home-manager.sharedModules = with inputs.self.modules.homeManager; [
      system-desktop
    ];
  };
}
