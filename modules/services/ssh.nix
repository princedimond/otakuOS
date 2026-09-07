{ ... }:
{
  flake.modules.nixos.ssh =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        ghostty
      ];
      services.openssh = {
        enable = true;
        openFirewall = true;
        settings = {
          PasswordAuthentication = true;
          PermitRootLogin = "no";
        };
      };
    };
}
