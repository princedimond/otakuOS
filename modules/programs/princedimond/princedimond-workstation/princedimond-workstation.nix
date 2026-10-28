{ ... }:
{
  flake.modules.nixos.princedimond-gaming =
    { pkgs, ... }:
    {

      nixpkgs.config.allowUnfreePackages = [
        "davinci-resolve"
      ];

      environment.systemPackages = with pkgs; [
        davinci-resolve
      ];
    };
}
