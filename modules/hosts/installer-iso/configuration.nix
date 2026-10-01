{ inputs, ... }:
{
  flake.modules.nixos.installer-iso =
    { lib, modulesPath, ... }:
    {
      networking.hostName = "installer-iso";

      imports = with inputs.self.modules.nixos; [
        (modulesPath + "/installer/cd-dvd/installation-cd-minimal.nix")
        system-cli
        installer-iso-keys
      ];

      home-manager.sharedModules = with inputs.self.modules.homeManager; [
        system-cli
      ];

      #Load up SSH keys into ISO
      environment.etc."ssh/ssh_host_ed25519_key" = {
        source = /run/agenix/iso-master-key;
        mode = "0600";
      };
      environment.etc."ssh/ssh_host_ed25519_key.pub" = {
        source = /run/agenix/iso-master-pub;
        mode = "0644";
      };
      systemd.services.sshd-keygen.enable = lib.mkForce false;
      services.openssh.hostKeys = [
        {
          path = "/etc/ssh/ssh_host_ed25519_key";
          type = "ed25519";
        }
      ];

      #Properly activate agenix
      systemd.services.agenix-activate = {
        description = "Run NixOS activation to decrypt agenix secrets";
        wantedBy = [ "multi-user.target" ];
        after = [ "local-fs.target" ];
        serviceConfig = {
          Type = "oneshot";
          ExecStart = "/nix/var/nix/profiles/system/activate";
          RemainAfterExit = true;
        };
      };

      #Fix some service ordering issues with agenix and home-manager
      systemd.services.home-manager-aqua.after = [ "agenix-activate.service" ];

      #Fix nix-daemon not properly setup on ISO for home manager to work
      nix.settings.build-users-group = lib.mkForce "nixbld";

      #Avoid pushing to cache from ISO
      nix.settings.post-build-hook = lib.mkForce null;

      #Disable autologin on tty
      services.getty.autologinUser = lib.mkForce null;

      #Disable broken kvantum theme on ISO
      environment.variables.QT_STYLE_OVERRIDE = lib.mkForce "";

    };
}
