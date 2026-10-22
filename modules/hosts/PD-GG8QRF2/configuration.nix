{ inputs, ... }:
{
  flake.modules.nixos.PD-GG8QRF2 = {
    networking.hostName = "PD-GG8QRF2";

    imports = with inputs.self.modules.nixos; [
      system-desktop
      intelcpu
      installer-iso-keys
    ];

    nix.daemonCPUSchedPolicy = "idle";

    nix.settings = {
      #cores = 1;
      max-jobs = 1;
    };

    home-manager.sharedModules = with inputs.self.modules.homeManager; [
      system-desktop
    ];
  };
}
