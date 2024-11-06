{lib, config, ...}: {
  options.modules.nixos.base.boot = {
    grub.enable = lib.mkEnableOption "Grub Bootloader";
    systemd-boot.enable = lib.mkEnableOption "systemd-boot Bootloader";
  };

  config = lib.mkMerge [
    {
      boot = {
        loader = {
          # wait for x seconds to select the boot entry
          timeout = lib.mkDefault 8;

          # allow the installation process to modify EFI boot variables
          efi.canTouchEfiVariables = lib.mkDefault true;
        };
      };

      # for power management
      services = {
        power-profiles-daemon = {
          enable = true;
        };
        upower.enable = true;
      };
    }

    (lib.mkIf config.modules.nixos.base.boot.grub.enable {
      ###################
      # Grub Bootloader #
      ###################
      boot.loader = {
        grub = {
          enable = true;
          device = "nodev";
          efiSupport = true;
          efiInstallAsRemovable = true;
        };

        # which conflict with `boot.loader.grub.efiInstallAsRemovable = true`
        efi.canTouchEfiVariables = lib.mkForce false;
      };
    })
    
    (lib.mkIf config.modules.nixos.base.boot.systemd-boot.enable {
      ###########################
      # systemd-boot Bootloader #
      ###########################
      boot.loader.systemd-boot = {
        # we use Git for version control, so we don't need to keep too many generations.
        configurationLimit = lib.mkDefault 10;

        # pick the highest resolution for systemd-boot's console.
        consoleMode = lib.mkDefault "max";
      };
    })
  ];
}
