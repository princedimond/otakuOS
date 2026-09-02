{ ... }:
{
  flake.modules.nixos.princedimond-gaming =
    { pkgs, ... }:
    {

      nixpkgs.config.allowUnfreePackages = [
        "parsec-bin"
      ];

      boot.kernelModules = [ "ntsync" ];
      programs.gamescope.enable = true;
      programs.gamemode.enable = true;

      environment.systemPackages = with pkgs; [
        parsec-bin
      ];
    };
}
