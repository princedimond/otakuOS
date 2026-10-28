{ inputs, ... }:
let
  username = "princedimond";
in
{
  flake.modules.nixos."${username}" =
    { pkgs, config, ... }:
    {

      home-manager.users."${username}" = {
        imports = [
          inputs.self.modules.homeManager."${username}"
        ];
      };

      pdpwd.file = ../../../secrets/pdpwd.age;

      users.users."${username}" = {
        isNormalUser = true;
        #initialPassword = "changeme";
        hashedPasswordFile = config.age.secrets.pdpwd.path;
        shell = pkgs.zsh;
        uid = 1000;
        extraGroups = [
          "networkmanager"
          "wheel"
          "dialout"
          "systemd-journal"
        ];
      };
    };
}
