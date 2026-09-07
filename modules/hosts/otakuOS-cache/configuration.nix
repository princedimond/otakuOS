{ inputs, ... }:
{
  flake.modules.nixos.otakuOS-cache = {
    networking.hostName = "otakuOS-cache";

    imports = with inputs.self.modules.nixos; [
      system-cli
      cache-srv
    ];

    home-manager.sharedModules = with inputs.self.modules.homeManager; [
      system-cli
    ];
  };
}
