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
              size = "24G";
              content = {
                type = "swap";
                resumeDevice = true;
              };
            };
            nix = {
              size = "100%";
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
                        "/persist" = {
                          mountOptions = [ "compress=zstd" ];
                          mountpoint = "/persist";
                        };
                        "/trash" = {
                          mountOptions = [ "compress=zstd" ];
                          mountpoint = "/.trash";
                        };
                        "/secret" = {
                          mountOptions = [ "compress=zstd" ];
                          mountpoint = "/.secret";
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
    };
    nodev = {
      "/" = {
        fsType = "tmpfs";
        mountOptions = [
          "defaults"
          "size=8G"
          "mode=755"
        ];
      };
    };
  };
}
