{ ... }:
{
  flake.modules.nixos.vm = {
    boot.kernelModules = [ "vboxvideo" ];
    virtualisation.virtualbox.guest = {
      enable = true;
      clipboard = true;
      dragAndDrop = true;
    };
    environment.sessionVariables = {
      LIBGL_ALWAYS_SOFTWARE = "1";
      WLR_RENDERER_ALLOW_SOFTWARE = "1";
    };
  };
}
