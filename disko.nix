{ lib, ... }:
{
  disko.devices.disk = lib.genAttrs [ "0" "1" ] (name: {
    type = "disk";
    device = "/dev/nvme${name}n1";
    content = {
      type = "gpt";
      partitions = {
        boot = {
          size = "1M";
          type = "EF02"; # for grub MBR
        };
        ESP = {
          size = "500M";
          type = "EF00";
          content = {
            type = "mdraid";
            name = "boot";
          };
        };
        swap = {
          size = "32G";
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
  });
  disko.devices.mdadm = {
    boot = {
      type = "mdadm";
      level = 1;
      metadata = "1.0";
      content = {
        type = "filesystem";
        format = "vfat";
        mountpoint = "/boot";
        mountOptions = [ "umask=0077" ];
      };
    };
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
      level = 1;
      content = {
        type = "luks";
        name = "crypted";
        settings = {
          fallbackToPassword = true;
          allowDiscards = true;
        };
	passwordFile = "/tmp/secret.key";
        #additionalKeyFiles = [
        #  "/dev/disk/by-uuid/076cadd8-df27-4431-8f9f-a59590e4c471"
        #];
        extraFormatArgs = [
          "--type luks2"
          "--cipher aes-xts-plain64"
          "--hash sha512"
          "--iter-time 5000"
          "--pbkdf argon2id"
          "--use-urandom" 
	  "--key-size 256"
        ];
        content = {
          type = "btrfs";
          extraArgs = [ "-f" ];
          subvolumes = {
            "/home" = {
              mountOptions = [ "compress=zstd" ];
              mountpoint = "/home";
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
  disko.devices.nodev = {
    "/" = {
      fsType = "tmpfs";
      mountOptions = [
        "defaults"
        "size=16G"
        "mode=755"
      ];
    };
  };
}
