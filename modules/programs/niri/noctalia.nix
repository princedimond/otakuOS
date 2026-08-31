{ inputs,... }:
{
  flake.modules.nixos.niri =
    { pkgs, ... }:
    {
      services.power-profiles-daemon.enable = true;
      services.upower.enable = true;
      environment.systemPackages = [
        inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];
    };

}
