{ inputs, ... }:
let
  flavor = "mocha";
  accent = "green";
in
{
  flake.modules.nixos.catppuccin-cli = {
    imports = [
      inputs.catppuccin.nixosModules.catppuccin
    ];

    catppuccin = {
      enable = true;
        flavor = "${flavor}";
        accent = "${accent}";
      cache.enable = true;
    };
  };

  flake.modules.homeManager.catppuccin-cli =
    {
      imports = [
        inputs.catppuccin.homeModules.catppuccin
      ];
      catppuccin = {
        enable = true;
        flavor = "${flavor}";
        accent = "${accent}";
        cache.enable = true;
      };
    };
}
