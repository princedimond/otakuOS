{ ... }:
{
  flake.modules.nixos.installer-iso-keys =
    { ... }:
    {
      age.secrets.iso-master-key = {
        file = ../../../secrets/iso-master-key.age;
      };

      age.secrets.iso-master-pub = {
        file = ../../../secrets/iso-master-pub.age;
      };
    };
}
