{ ... }:
{
  flake-file.inputs = {
    impermanence.url = "github:nix-community/impermanence";
    impermanence.inputs.nixpkgs.follows = "nixpkgs";
  };
}
