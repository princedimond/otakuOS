{ inputs, ... }:
{
  flake.modules.nixos.disko =
    { config, lib, ... }:
    {
      imports = [ inputs.disko.nixosModules.disko ];
      
      options.disko = {
        device = lib.mkOption {
          type = lib.types.str;
          example = "/dev/sda";
          description = "Block device to partition for this host.";
        };
      };

      config = {
        disko.devices = {
          disk.main = {
            device = config.disko.device;
            type = "disk";
            content = {
              type = "gpt";
              partitions = {
                ESP = {
                  size = "2G";
                  type = "EF00";
                  content = {
                    type = "filesystem";
                    format = "vfat";
                    mountpoint = "/boot";
                    mountOptions = [ "umask=0077" ];
                  };
                };

                root = {
                  size = "100%";
                  content = {
                    type = "btrfs";
                    extraArgs = [ "-f" ];

                    postCreateHook = ''
                      MNTPOINT=$(mktemp -d)
                      mount -t btrfs -o subvol=/ "$(readlink -f ${config.disko.device})1"* "$MNTPOINT" 2>/dev/null || \
                        mount -t btrfs -o subvol=/ /dev/disk/by-partlabel/disk-main-root "$MNTPOINT"
                      trap 'umount "$MNTPOINT"; rmdir "$MNTPOINT"' EXIT
                      btrfs subvolume snapshot -r "$MNTPOINT/@root" "$MNTPOINT/@root-empty"
                    '';

                    subvolumes = {
                      "@root" = {
                        mountpoint = "/";
                        mountOptions = [ "compress=zstd" "noatime" ];
                      };
                      "@nix-store" = {
                        mountpoint = "/nix";
                        mountOptions = [ "compress=zstd" "noatime" ];
                      };
                      "@persist" = {
                        mountpoint = "/persist";
                        mountOptions = [ "compress=zstd" "noatime" ];
                      };
                    };
                  };
                };
              };
            };
          };
        };
      };
    };
}