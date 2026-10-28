{ inputs, ... }:
{
  flake.modules.nixos.PD-19KDH72 = {
    networking.hostName = "PD-19KDH72";

    imports = with inputs.self.modules.nixos; [
      system-desktop
      intelcpu
      impermanence
    ];

    home-manager.sharedModules = with inputs.self.modules.homeManager; [
      system-desktop
    ];
  };
}
