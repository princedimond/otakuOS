{ inputs, ... }:
let
  home-manager-config = {
    home-manager = {
      backupFileExtension = "hmBAK";
    };
  };
in
{
  flake.modules.nixos.home-manager = {
    imports = [
      inputs.home-manager.nixosModules.home-manager
      home-manager-config
    ];
  };
}
