{ ... }:
{
  flake.modules.nixos.amdcpu = {
    hardware.cpu.amd.updateMicrocode = true;
    boot.kernelModules = [ "kvm-amd" ];
  };
}
