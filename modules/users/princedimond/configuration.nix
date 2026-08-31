{ inputs, ... }:
let
  username = "princedimond";
in
{
  flake.modules.nixos."${username}" =
    { pkgs, ... }:
    {

      home-manager.users."${username}" = {
        imports = [
          inputs.self.modules.homeManager."${username}"
        ];
      };

      users.users."${username}" = {
        isNormalUser = true;
        initialPassword = "changeme";
        extraGroups = [
          "networkmanager"
          "wheel"
          "dialout"
          "systemd-journal"
        ];
      };
    };
}
