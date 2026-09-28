{ ... }:
{
  flake.modules.nixos.PD-GG8QRF2 = {
    boot.initrd.availableKernelModules = [
      "xhci_pci"
      "ahci"
      "usb_storage"
      "sd_mod"
      "rtsx_pci_sdmmc"
    ];
    boot.initrd.kernelModules = [ ];
    boot.kernelModules = [ ];
    boot.extraModulePackages = [ ];
  };
}
