{ ... }:
{
  flake-file.inputs = {
    nur = {
      url = "github:nix-community/nur";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
