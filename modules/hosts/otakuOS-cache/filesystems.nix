{ ... }:
{
  flake.modules.nixos.otakuOS-cache = {
    fileSystems."/" = {
      device = "/dev/disk/by-uuid/eee6e7a1-16c6-4938-8887-2bc0bc3566f6";
      fsType = "btrfs";
    };

    fileSystems."/home" = {
      device = "/dev/disk/by-uuid/eee6e7a1-16c6-4938-8887-2bc0bc3566f6";
      fsType = "btrfs";
      options = [ "subvol=home" ];
    };

    fileSystems."/nix" = {
      device = "/dev/disk/by-uuid/eee6e7a1-16c6-4938-8887-2bc0bc3566f6";
      fsType = "btrfs";
      options = [ "subvol=nix" ];
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/19ED-4E07";
      fsType = "vfat";
      options = [
        "fmask=0077"
        "dmask=0077"
      ];
    };
  };
}
