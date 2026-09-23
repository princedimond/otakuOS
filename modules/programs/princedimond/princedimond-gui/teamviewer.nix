{ ... }:
{
  flake.modules.nixos.princedimond-gui =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        teamviewer
      ];
      services.teamviewer.enable = true;
    };
}
