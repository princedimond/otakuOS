{ ... }:
{
  flake-file.inputs = {
    nix-craftapps = {
         url = "github:olafkfreund/nix-craftapps";
         inputs.nixpkgs.follows = "nixpkgs";
       }; 
  };
}
