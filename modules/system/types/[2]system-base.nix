{ inputs, ... }:
{
  flake.modules.nixos.system-base = {
    imports = with inputs.self.modules.nixos; [
      princedimond
      system-core
      home-manager
      nur
      networkManager
      bluetooth
      agenix
    ];
  };

  flake.modules.homeManager.system-base = {
    imports = with inputs.self.modules.homeManager; [
      system-core
      nur
      princedimond
      agenix
    ];
  };
}
