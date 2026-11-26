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
        cpufetch
        ramfetch
        microfetch
        curl
        pciutils
        direnv
        btop
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
        zip
        unzip
        unrar
        p7zip
      ];
    };
}
