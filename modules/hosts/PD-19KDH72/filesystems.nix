{ ... }:
{
  flake.modules.nixos.PD-19KDH72 = {
    fileSystems = {
      "/" = {
        device = "/dev/disk/by-uuid/[UUID]";
        fsType = "btrfs";
      };
      "/boot" = {
        device = "/dev/disk/by-uuid/[UUID]";
        fsType = "vfat";
        options = [
          "fmask=0077"
          "dmask=0077"
        ];
      };
    };
  };
}
