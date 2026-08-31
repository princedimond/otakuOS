{ ... }:
{
  flake.modules.nixos.amdgpu =
    { pkgs, ... }:
    {
      hardware.graphics.enable = true;
      hardware.graphics.enable32Bit = true;
      hardware.graphics.extraPackages = with pkgs; [
        rocmPackages.clr.icd
      ];
      hardware.amdgpu.initrd.enable = true;
      hardware.amdgpu.opencl.enable = true;
      services.xserver.videoDrivers = [ "amdgpu" ];
      environment.systemPackages = with pkgs; [
        nvtopPackages.amd
      ];
    };
}
