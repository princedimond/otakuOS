{ ... }:
{
  flake-file.inputs = {
    catppuccin = {
      url = "github:catppuccin/nix/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };
}
