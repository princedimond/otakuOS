{ inputs, ... }:
{
  flake.modules.nixos.nur = {
    nixpkgs.overlays = [
      inputs.nur.overlays.default
    ];
  };

  flake.modules.homeManager.nur = {
    nixpkgs.overlays = [
      inputs.nur.overlays.default
    ];
  };
}
