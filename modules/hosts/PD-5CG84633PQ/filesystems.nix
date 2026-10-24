{ inputs, ... }:
{
  flake.modules.nixos.PD-5CG84633PQ =
    { pkgs, config, ... }:
    {
      imports = with inputs.self.modules.nixos; [
        disko-encrypted
      ];

      disko.device = "/dev/disk/by-id/nvme-SAMSUNG_MZVLB256HAHQ-000H1_S425NX0K842435";
    };
}
