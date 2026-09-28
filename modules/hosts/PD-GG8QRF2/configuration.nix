{ inputs, ... }:
{
  flake.modules.nixos.PD-GG8QRF2 = {
    networking.hostName = "PD-GG8QRF2";

    imports = with inputs.self.modules.nixos; [
      system-desktop
      intelcpu
    ];

    home-manager.sharedModules = with inputs.self.modules.homeManager; [
      system-desktop
    ];
  };
}
