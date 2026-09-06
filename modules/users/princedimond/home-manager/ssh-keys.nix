{ ... }:
{
  flake.modules.nixos.princedimond = {
    age.secrets = {
      pdssh-pub = {
        file = ../../../../secrets/pdssh-pub.age;
        owner = "princedimond";
      };
      pdssh-private = {
        file = ../../../../secrets/pdssh-private.age;
        owner = "princedimond";
      };
    };
  };
  flake.modules.homeManager.princedimond =
    { config, ... }:
    {
      home.file = {
        ".ssh/id_ed25519.pub".source = config.lib.file.mkOutOfStoreSymlink /run/agenix/pdssh-pub;
        ".ssh/id_ed25519".source = config.lib.file.mkOutOfStoreSymlink /run/agenix/pdssh-private;
      };
    };
}
