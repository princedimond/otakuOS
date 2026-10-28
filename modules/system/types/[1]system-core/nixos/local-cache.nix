{
  flake.modules.nixos.system-core =
    { config, pkgs, ... }:
    {
      age.secrets.attic-token.file = ../../../../../secrets/attic-token.age;

      nix.settings = {
        substituters = [
          "https://otakuOS-nix-cache.behemothtechnologies.net/otakuOS-cache"
        ];

        trusted-public-keys = [
          "otakuOS-cache:eWlnqPfM6EsqN8if55rbNeXoY9HZvZ641djU9g9wbM8="
        ];

        netrc-file = config.age.secrets.attic-token.path;

      };
      systemd.services.attic-watch-store = {
        description = "Push new store paths to the otakuOS-cache Attic cache";
        wantedBy = [ "multi-user.target" ];
        wants = [ "network-online.target" ];
        after = [ "network-online.target" ];
        path = [
          pkgs.attic-client
          pkgs.gawk
        ];
        environment.XDG_CONFIG_HOME = "/run/attic-watch";
        serviceConfig = {
          Restart = "always";
          RestartSec = 30;
          RuntimeDirectory = "attic-watch";
          RuntimeDirectoryMode = "0700";
        };
        script = ''
          TOKEN=$(awk '/^password/ {print $2}' ${config.age.secrets.attic-token.path})
          attic login otakuOS-cache https://otakuOS-nix-cache.behemothtechnologies.net "$TOKEN"
          exec attic watch-store -j 1 otakuOS-cache
        '';
      };
    };
}
