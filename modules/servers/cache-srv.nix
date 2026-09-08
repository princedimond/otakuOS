{ ... }:
{
  flake.modules.nixos.cache-srv =
    { pkgs, config, ... }:
    {
      environment.systemPackages = [
        pkgs.attic-server
        pkgs.attic-client
      ];
      age.secrets = {
        attic-env = {
          file = ../../secrets/attic-env.age;
        };
      };
      services.atticd = {
        enable = true;
        settings = {
          listen = "0.0.0.0:3263";

          garbage-collection = {
            interval = "12h";
            default-retention-period = "60d";
          };
        };
        environmentFile = config.age.secrets.attic-env.path;
      };
    };
}
