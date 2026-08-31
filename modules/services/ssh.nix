{ ... }:
{
  flake.modules.nixos.ssh =
    { pkgs, ... }:
    {
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
