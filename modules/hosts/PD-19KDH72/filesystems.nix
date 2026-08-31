{ ... }:
{
  flake.modules.nixos.PD-19KDH72 = {
    fileSystems."/" =
        { device = "/dev/disk/by-uuid/0ca27e97-faca-41b9-8554-fd3d348096b6";
          fsType = "btrfs";
        };

      fileSystems."/home" =
        { device = "/dev/disk/by-uuid/0ca27e97-faca-41b9-8554-fd3d348096b6";
          fsType = "btrfs";
          options = [ "subvol=home" ];
        };

      fileSystems."/nix" =
        { device = "/dev/disk/by-uuid/0ca27e97-faca-41b9-8554-fd3d348096b6";
          fsType = "btrfs";
          options = [ "subvol=nix" ];
        };

      fileSystems."/boot" =
        { device = "/dev/disk/by-uuid/2388-D4A7";
          fsType = "vfat";
          options = [ "fmask=0077" "dmask=0077" ];
        };
  };
}
