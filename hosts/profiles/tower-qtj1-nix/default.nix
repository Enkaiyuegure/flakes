# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:
let
  nvidia-offload = pkgs.writeShellScriptBin "nvidia-offload" ''
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __NV_PRIME_RENDER_OFFLOAD_PROVIDER=NVIDIA-G0
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __VK_LAYER_NV_optimus=NVIDIA_only
    exec "$@"
  '';
in
{
  imports =
    [
      # Include the results of the hardware scan.
      ./password
      ./hardware-configuration.nix
      ./modules.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot = {
    bootspec.enable = true;
    loader = {
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
        efiInstallAsRemovable = true;
      };
      efi = {
        #canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
      timeout = 3;
    };
    consoleLogLevel = 0;
    initrd.verbose = false;
  };

  networking.hostName = "tower-qtj1-nix"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "en_US.UTF-8";
  # console = {
  #   font = "Lat2-Terminus16";
  #   keyMap = "us";
  #   useXkbConfig = true; # use xkb.options in tty.
  # };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;

  boot.swraid.mdadmConf = ''
    MAILADDR enkaiyuegure@outlook.com
    PROGRAM /nix/store/rk067yylvhyb7a360n8k1ps4lb4xsbl3-coreutils-9.3/bin/true
  '';

  fileSystems."/persist".neededForBoot = true;
  fileSystems."/.secret".neededForBoot = true;

  services._3proxy = {
    enable = true;
    services = [
      {
        type = "proxy";
        #bindAddress = "192.168.1.24";
        bindPort = 3128;
        auth = [ "iponly" ];
      }
      {
        type = "socks";
        #bindAddress = "172.17.0.1";
        bindPort = 1080;
        auth = [ "strong" ];
        acl = [
          {
            rule = "allow";
            users = [ "httproxy" ];
          }
        ];
      }
    ];
    usersFile = "/.secret/3proxy.passwd";
  };

  # Configure keymap in X11
  # services.xserver.xkb.layout = "us";
  # services.xserver.xkb.options = "eurosign:e,caps:escape";

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware = {
    opengl.enable = true;

    nvidia = {
      open = false;
      package = config.boot.kernelPackages.nvidiaPackages.latest;
      modesetting.enable = true;
      powerManagement = {
        enable = false;
        finegrained = false;
      };
      nvidiaSettings = true;
    };
    pulseaudio.support32Bit = true;
  };

  environment.variables = {
    # WLR_RENDERER = "vulkan";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    GBM_BACKEND = "nvidia-drm";
    WLR_NO_HARDWARE_CURSORS = "1";
    WLR_RENDERER_ALLOW_SOFTWARE = "1";
  };
  # Enable sound.
  # hardware.pulseaudio.enable = true;
  # OR
  # services.pipewire = {
  #   enable = true;
  #   pulse.enable = true;
  # };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  environment = {
    binsh = "${pkgs.dash}/bin/dash";
    shells = with pkgs; [ fish ];
    systemPackages = (with pkgs; [
      cargo
      glow
      nix-output-monitor
      libva
      libva-utils
      glxinfo
    ]) ++ [
      nvidia-offload
    ];
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  nix = {
    channel.enable = false;
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      substituters = [
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
      trusted-users = [ "root" "@wheel" ];
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 2d";
    };
  };

  boot.kernelPackages = pkgs.linuxPackages_zen;

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;
  users.users.enkai = {
    description = "Enkaiyuegure";
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCYfzHsu8HcbQUNyLk0b7zOfy3tXk0gMsrgBi0u8CEHDncWgMxgQ77dgDLHXpcXEY3KaGHPDyTKtnCKv7hPVuRQjkbsaoHhiVJW7qcmEbCmuZgsllYqIn2I3mFO6Ubckdu+JWjfOkUhVRFl5ZG5eI4mqZFyjFdDlSGSiFmS81qB5ry6mGInzZYnJuROTwiei8vW2yTfAIloAFPghq8qTzrcuMUXL7gVinaxrU7jVozEtJe0KR07oBpr/jUaeomuzy3R29CPu6+BBxRAMo6U02NxtevI+n0d1i5PbXRuZ8xxwWVQzlwkL9DjHls1tHUlZkYvnvYzHU/FUMlRuELPK+M3LS+ILqzCkK2D32UmukcFrcXnNe9TQy/3D0WI+m8lK69n67tskqaD84wxNAbnMjHMUcbX02BOXl+qTcG0nGP1cMbZrWvXbwkqhW4N6a97EKLxpOIA1gBQ3K6CFStdtKeXzMSkgfPap85x5cr3Zg03ZNOtw2QrZuCrAhO1JZHhF2Eqgx+kbmQGttouAs6Ftj1AX3ZNpTOXWk5Ryd6nH6SW68uv+u+ehUaU8n4TsmAAX27cX19K6IpKFJlKL6VB/BjtnyHj+HyjR0vDsSE5pdCiDY+bFPw0lkNn2vZE9UMUUepRSvi+qKmSI+9ZLpd/o6ZIclT/SHyLVOSnYSXnSzAetQ== enkaiyuegure@outlook.com"
    ];
  };


  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
}
