{ inputs,... }:
{
  flake.modules.nixos.niri =
    { ... }:
    {
      imports = [
       inputs.niri.nixosModules.niri
      ];
      programs.niri.enable = true;
    };

}
