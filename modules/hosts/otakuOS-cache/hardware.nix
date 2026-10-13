{ ... }:
{
  flake.modules.nixos.otakuOS-cache = {
    boot.initrd.availableKernelModules = [ "ata_piix" "uhci_hcd" "ahci" "sd_mod" "sr_mod" ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ ];
    boot.extraModulePackages = [ ];
  };
}
