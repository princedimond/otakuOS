{ inputs,... }:
{
  flake.modules.nixos.niri =
    { pkgs, ... }:
    {
      nix.settings = {
        extra-substituters = [ "https://noctalia.cachix.org" ];
        extra-trusted-public-keys = [ "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4=" ];
      };
      services.power-profiles-daemon.enable = true;
      services.upower.enable = true;
      environment.systemPackages = [
        inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];
    };

}
