{ inputs, ... }:
{
  flake.modules.nixos.niri =
    { pkgs, ... }:
    {
      imports = [
        inputs.niri.nixosModules.niri
      ];
      environment.systemPackages = with pkgs; [
        xwayland-satellite
      ];
      programs.niri.enable = true;
    };

}
