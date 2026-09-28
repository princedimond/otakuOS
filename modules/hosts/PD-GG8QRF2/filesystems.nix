{ ... }:
{
  flake.modules.nixos.PD-GG8QRF2 = {
    fileSystems."/" = {
      device = "/dev/mapper/luks-966b779e-7201-4fdb-9c70-f19c15d9c345";
      fsType = "btrfs";
    };

    boot.initrd.luks.devices."luks-966b779e-7201-4fdb-9c70-f19c15d9c345".device =
      "/dev/disk/by-uuid/966b779e-7201-4fdb-9c70-f19c15d9c345";

    fileSystems."/home" = {
      device = "/dev/mapper/luks-966b779e-7201-4fdb-9c70-f19c15d9c345";
      fsType = "btrfs";
      options = [ "subvol=home" ];
    };

    fileSystems."/nix" = {
      device = "/dev/mapper/luks-966b779e-7201-4fdb-9c70-f19c15d9c345";
      fsType = "btrfs";
      options = [ "subvol=nix" ];
    };

    fileSystems."/boot" = {
      device = "/dev/disk/by-uuid/D58B-2484";
      fsType = "vfat";
      options = [
        "fmask=0077"
        "dmask=0077"
      ];
    };

    swapDevices = [
      { device = "/dev/mapper/luks-3a860ec2-ea71-40fc-9dfd-a2f07ee00cc6"; }
    ];
  };
}
