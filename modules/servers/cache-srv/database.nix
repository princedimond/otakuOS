{ ... }:
{
  flake.modules.nixos.cache-srv =
    { pkgs, config, ... }:
    {
      services.postgresql = {
        enable = true;
        package = pkgs.postgresql_16;

        ensureDatabases = [ "attic" ];

        # Create the database user and grant permissions
        ensureUsers = [
          {
            name = "atticd";
            ensureDBOwnership = true;
          }
        ];
      };
    };
}
