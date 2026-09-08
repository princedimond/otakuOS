{ ... }:
{
  flake.modules.nixos.princedimond-cli =
    { pkgs, ... }:
    {
      nixpkgs.config.allowUnfreePackages = [
        "unrar"
      ];
      environment.systemPackages = with pkgs; [
        wget
        fastfetch
        onefetch
        curl
        pciutils
        direnv
        btop
        resources
        nh
        dmidecode
        cpu-x
        lshw
        dut
        duc
        libevdev
        libimobiledevice
        libimobiledevice-glue
        ifuse
      ];
    };
}
