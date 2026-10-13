{ inputs, ... }:
{
  flake.modules.nixos.otakuOS-cache =
    { pkgs, config, ... }:
    {
      imports = with inputs.self.modules.nixos; [
        disko
      ];

      disko.device = "/dev/disk/by-id/ata-QEMU_HARDDISK_QM00005";
    };
}
