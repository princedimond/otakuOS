{ ... }:
{
  flake.modules.nixos.princedimond-cli =
    { pkgs, config, ... }:
    {
      nixpkgs.config.allowUnfreePackages = [
        "expressvpn"
      ];
      environment.systemPackages = with pkgs; [
        expressvpn
      ];
      services.expressvpn.enable = true;
    };
}
