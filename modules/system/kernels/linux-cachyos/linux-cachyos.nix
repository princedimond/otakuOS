{ inputs, ... }:
{
  flake.modules.nixos.linux-cachyos =
    { pkgs, ... }:
    {
      nixpkgs.overlays = [
        inputs.nix-cachyos-kernel.overlays.pinned
      ];

      nix.settings.substituters = [ "https://attic.xuyh0120.win/lantian" ];
      nix.settings.trusted-public-keys = [ "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc=" ];

      boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;
    };
}
