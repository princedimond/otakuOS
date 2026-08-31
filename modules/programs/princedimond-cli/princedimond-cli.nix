{ ... }:
{
  flake.modules.nixos.princedimond-cli =
    { pkgs, ... }:
    {
      nixpkgs.config.allowUnfreePackages = [
        "unrar"
      ];
      environment.systemPackages = with pkgs; [
        git
        wget
        curl
        yazi
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
