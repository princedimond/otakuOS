{ ... }:
{
  flake-file.inputs = {
    niri = {
      url = "github:dc-tec/niri-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
