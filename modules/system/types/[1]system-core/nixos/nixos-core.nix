{ inputs, ... }:
{
  flake.modules.nixos.system-core =
    { ... }:
    {
      boot.loader.systemd-boot.enable = true;
      boot.loader.efi.canTouchEfiVariables = true;
      hardware.enableRedistributableFirmware = true;
      services.automatic-timezoned.enable = true;

      system.stateVersion = "26.05";
      environment.sessionVariables = {
        XDG_CONFIG_HOME = "$HOME/.config";
        XDG_CACHE_HOME = "$HOME/.cache";
        XDG_DATA_HOME = "$HOME/.local/share";
        XDG_STATE_HOME = "$HOME/.local/state";
      };

      #Overlay nixpkgs-unstable and nixpkgs-master to pkgs.unstable and pkgs.master
      nixpkgs.overlays = [
        (final: _: {
          unstable = import inputs.nixpkgs-unstable {
            inherit (final.stdenv.hostPlatform) system;
            inherit (final) config;
          };
        })
        (final: _: {
          master = import inputs.nixpkgs-master {
            inherit (final.stdenv.hostPlatform) system;
            inherit (final) config;
          };
        })
      ];

      nix = {
        settings = {
          use-xdg-base-directories = true;

          substituters = [
            "https://cache.nixos.org?priority=10"
            "https://nix-community.cachix.org"
          ];

          trusted-public-keys = [
            "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
            "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
          ];

          experimental-features = [
            "nix-command"
            "flakes"
          ];

          trusted-users = [
            "root"
            "@wheel"
          ];
        };
      };

      security.sudo.extraConfig = ''
        Defaults timestamp_timeout=-1
      '';

      i18n.defaultLocale = "en_US.UTF-8";
      i18n.extraLocaleSettings = {
        LC_ADDRESS = "en_US.UTF-8";
        LC_IDENTIFICATION = "en_US.UTF-8";
        LC_MEASUREMENT = "en_US.UTF-8";
        LC_MONETARY = "en_US.UTF-8";
        LC_NAME = "en_US.UTF-8";
        LC_NUMERIC = "en_US.UTF-8";
        LC_PAPER = "en_US.UTF-8";
        LC_TELEPHONE = "en_US.UTF-8";
        LC_TIME = "en_US.UTF-8";
      };
    };
}
