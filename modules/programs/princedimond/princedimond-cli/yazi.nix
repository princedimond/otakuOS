{ ... }:
{
  flake.modules.nixos.princedimond-cli =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        yazi
      ];
    };

  flake.modules.homeManager.princedimond-cli = {
    programs.yazi = {
      enable = true;
    };
  };
}
