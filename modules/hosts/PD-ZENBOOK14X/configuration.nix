{ inputs, ... }:
{
  flake.modules.nixos.PD-ZENBOOK14X = {
    networking.hostName = "PD-ZENBOOK14X";

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
