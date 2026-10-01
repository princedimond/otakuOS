{ ... }:
{
  flake.modules.nixos.installer-iso =
    { pkgs, ... }:
    {
      #Import installer.sh to root of ISO
      environment.systemPackages = [
        (pkgs.writeShellScriptBin "custom-install" (builtins.readFile ./installer.sh))
      ];
    };
}
