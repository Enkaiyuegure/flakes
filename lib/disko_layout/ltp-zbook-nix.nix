{
  disko.devices = {
    disk = {
      vdb = {
        type = "disk";
        device = "/dev/nvme0n1";
        content = {
          type = "gpt";
          partitions = {
            esp = {
              priority = 1;
              size = "512M";
              type = "EF00";
              content = {
                type = "filesystem";
                format = "vfat";
                mountpoint = "/boot/efi";
              };
            };
            swap = {
              size = "48G";
              content = {
                type = "mdraid";
                name = "swap";
              };
            };
            nix = {
              size = "100%";
              content = {
                type = "mdraid";
                name = "nix";
              };
            };
          };
        };
      };
      vdc = {
        type = "disk";
        device = "/dev/nvme1n1";
        content = {
          type = "gpt";
          partitions = {
            livecd = {
              size = "512M";
              content = {
                type = "filesystem";
                format = "ext4";
              };
            };
            swap = {
              size = "48G";
              content = {
                type = "mdraid";
                name = "swap";
              };
            };
            nix = {
              size = "100%";
              content = {
                type = "mdraid";
                name = "nix";
              };
            };
          };
        };
      };
    };
    mdadm = {
      swap = {
        type = "mdadm";
        level = 0;
        content = {
          type = "swap";
          resumeDevice = true;
        };
      };
      nix = {
        type = "mdadm";
        level = 0;
        content = {
          type = "gpt";
          partitions = {
            primary = {
              size = "100%";
              content = {
                type = "btrfs";
                extraArgs = [ "-f" ];
                subvolumes = {
                  "/home" = {
                    mountpoint = "/home";
                  };
                  "/boot" = {
                    mountOptions = [ "compress=zstd" "noatime" ];
                    mountpoint = "/boot";
                  };
                  "/nix" = {
                    mountOptions = [ "compress=zstd" "noatime" ];
                    mountpoint = "/nix";
                  };
                  "/@persist" = {
                    mountOptions = [ "compress=zstd" ];
                    mountpoint = "/persist";
                  };
                };
              };
            };
          };
        };
      };
    };
    nodev = {
      "/" = {
        fsType = "tmpfs";
        mountOptions = [
          "defaults"
          "size=16G"
          "mode=755"
        ];
      };
    };
  };
}
