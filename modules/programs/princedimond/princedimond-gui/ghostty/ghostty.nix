{ ... }:
{
  flake.modules.nixos.princedimond-gui =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        ghostty
      ];

    };

  flake.modules.homeManager.princedimond-gui = {

  };
}
