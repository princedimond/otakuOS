{ ... }:
{
  flake.modules.nixos.princedimond-gui =
    { pkgs, ... }:
    {
      nixpkgs.config.allowUnfreePackages = [
        "cisco-packet-tracer"
      ];

      environment.systemPackages = with pkgs; [
        cisco-packet-tracer_9
      ];

      nixpkgs.overlays = [
        (final: prev: {
          cisco-packet-tracer_9 = prev.cisco-packet-tracer_9.override {
            requireFile =
              _:
              final.fetchurl {
                url = "https://archive.org/download/packet-tracer-v9.0.1-ubuntu-windows/CiscoPacketTracer_901_Ubuntu_64bit.deb";
                name = "CiscoPacketTracer_901_Ubuntu_64bit.deb";
                hash = "sha256-NoPdh+d5iFNyrpo1wabllNEvST5knnxpdAhynBRZR5s=";
              };
          };
        })
      ];

      /*
        system.extraDependencies = [
          (pkgs.fetchurl {
            name = "CiscoPacketTracer_901_Ubuntu_64bit.deb";
            url = "https://archive.org/download/packet-tracer-v9.0.1-ubuntu-windows/CiscoPacketTracer_901_Ubuntu_64bit.deb";
            hash = "sha256-NoPdh+d5iFNyrpo1wabllNEvST5knnxpdAhynBRZR5s=";
          })
        ];
      */
    };
}
