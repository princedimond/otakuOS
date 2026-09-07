{ ... }:
{
  flake.modules.nixos.disko =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [

      ];
    };

  flake.modules.homeManager.disko =
    { pkgs, ... }:
    {
    };
}
