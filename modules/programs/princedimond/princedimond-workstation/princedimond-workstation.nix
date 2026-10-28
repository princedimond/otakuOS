{ ... }:
{
  flake.modules.nixos.princedimond-workstation =
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
