{ ... }:
{
  flake.modules.nixos.intelcpu = {
    hardware.cpu.intel.updateMicrocode = true;
    boot.kernelModules = [ "kvm-intel" ];
  };
}
