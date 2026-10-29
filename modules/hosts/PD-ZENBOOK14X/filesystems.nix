{ inputs, ... }:
{
  flake.modules.nixos.PD-ZENBOOK14X =
    { pkgs, config, ... }:
    {
      imports = with inputs.self.modules.nixos; [
        disko-encrypted
      ];

      disko.device = "/dev/disk/by-id/nvme-SAMSUNG_MZVL4512HBLU-00BTW_S73DNU2W217539";
    };
}
