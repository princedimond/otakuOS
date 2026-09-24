{ ... }:
{
  flake.modules.nixos.princedimond-gui =
    { pkgs, ... }:
    {
      nixpkgs.config.allowUnfreePackages = [
        "teamviewer"
      ];
      environment.systemPackages = with pkgs; [
        teamviewer
      ];
      services.teamviewer.enable = true;
    };
}
