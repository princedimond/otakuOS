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
        curl
        yazi
        pciutils
        direnv
        btop
        resources
        rar
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
