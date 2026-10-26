{ inputs, ... }:
{
  flake.modules.nixos.PD-19KDH72 =
    { pkgs, config, ... }:
    {
      imports = with inputs.self.modules.nixos; [
        disko-encrypted
      ];

      disko.device = "/dev/disk/by-id/ata-SanDisk_X300_MSATA_256GB_154732401048";
    };
}
