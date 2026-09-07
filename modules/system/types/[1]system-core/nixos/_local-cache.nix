{
  flake.modules.nixos.system-core =
    { config, pkgs, ... }:
    {
      age.secrets.attic-token.file = ../../../../../secrets/attic-token.age;

      nix.settings = {
        substituters = [
          "http://10.10.0.192/otakuOS-cache"
        ];

        trusted-public-keys = [
          "otakuOS-cache:oe9JlLaInZD/a4I2wnzZEftEW+/FjzOdlFJ3Ueg//7E="
        ];
        netrc-file = config.age.secrets.attic-token.path;

        post-build-hook = pkgs.writeShellScript "attic-push" ''
          set -eu
          set -f
          export PATH="${pkgs.attic-client}/bin:$PATH"

          TOKEN=$(${pkgs.gawk}/bin/awk '/^password/ {print $2}' ${config.age.secrets.attic-token.path})
          attic login otakuOS-cache http://10.10.0.192 "$TOKEN"
          attic push otakuOS-cache $OUT_PATHS
        '';
      };
    };
}
