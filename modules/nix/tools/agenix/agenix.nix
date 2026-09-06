{ inputs, ... }:
{
  flake.modules.nixos.agenix = {
    environment.systemPackages = [
      inputs.agenix.packages.x86_64-linux.default
    ];

    imports = [
      inputs.agenix.nixosModules.default
    ];

  };

  flake.modules.homeManager.agenix = {
    imports = [
      inputs.agenix.homeManagerModules.default
    ];
  };
}
