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
      system.extraDependencies = [
        (pkgs.fetchurl {
          name = "CiscoPacketTracer_900_Ubuntu_64bit.deb";
          url = "https://archive.org/download/packettracer900/CiscoPacketTracer_900_Ubuntu_64bit.deb";
          hash = "sha256-3ZrA1Mf8N9y2j2J/18fm+m1CAMFEklJuVhi5vRcu2SA=";
        })
      ];
    };
}
