{ pkgs
, myVars
, ...
}: 
let
  inherit (myVars) userName;
in
{
  environment.systemPackages = [
    # `sudo ncdu -x /`
    pkgs.ncdu
  ];

  # issue: https://github.com/nix-community/impermanence/issues/229
  # Use symlink
  systemd.tmpfiles.rules = [
    "L /etc/machine-id - - - - /persist/etc/machine-id"
  ];
  # Or
  # boot.initrd.systemd.suppressedUnits = [ "systemd-machine-id-commit.service" ];
  # systemd.suppressedSystemUnits = [ "systemd-machine-id-commit.service" ];

  # There are two ways to clear the root filesystem on every boot:
  ##  1. use tmpfs for /
  ##  2. (btrfs/zfs only)take a blank snapshot of the root filesystem and revert to it on every boot via:
  ##     boot.initrd.postDeviceCommands = ''
  ##       mkdir -p /run/mymount
  ##       mount -o subvol=/ /dev/disk/by-uuid/UUID /run/mymount
  ##       btrfs subvolume delete /run/mymount
  ##       btrfs subvolume snapshot / /run/mymount
  ##     '';
  #
  #  See also https://grahamc.com/blog/erase-your-darlings/

  # NOTE: impermanence only mounts the directory/file list below to /persistent
  # If the directory/file already exists in the root filesystem, you should
  # move those files/directories to /persistent first!
  environment.persistence."/persist" = {
    # sets the mount option x-gvfs-hide on all the bind mounts
    # to hide them from the file manager
    hideMounts = true;
    directories = [
      "/etc/NetworkManager/system-connections"
      "/etc/ssh"
      "/etc/nix/inputs"
      "/etc/secureboot" # lanzaboote - secure boot

      "/var/log"
      "/var/lib"

      # created by modules/nixos/misc/fhs-fonts.nix
      # for flatpak apps
      # "/usr/share/fonts"
      # "/usr/share/icons"
    ];
    files = [
      #"/etc/machine-id"
      "/etc/create-ap.conf"
    ];

    # the following directories will be passed to /persistent/home/$USER
    users.${userName} = {
      directories = [
        "Codes"
        "Projects"
        "Flakes"
        "tmp"

        "Downloads"
        "Music"
        "Pictures"
        "Documents"
        "Videos"

        {
          directory = ".gnupg";
          mode = "0700";
        }
        {
          directory = ".ssh";
          mode = "0700";
        }

        # misc
        ".config/pulse"
        ".pki"
        ".steam" # steam games

        # cloud native
        {
          # pulumi - infrastructure as code
          directory = ".pulumi";
          mode = "0700";
        }
        {
          directory = ".aws";
          mode = "0700";
        }
        {
          directory = ".docker";
          mode = "0700";
        }
        {
          directory = ".kube";
          mode = "0700";
        }

        # remote desktop
        ".config/remmina"
        ".config/freerdp"

        # doom-emacs
        # ".config/emacs"
        "org" #  org files

        # vscode
        ".vscode"
        ".vscode-insiders"
        ".config/Code/User"
        ".config/Code - Insiders/User"

        # browsers
        ".mozilla"
        ".config/google-chrome"

        # neovim / remmina / flatpak / ...
        ".local/share"
        ".local/state"

        # neovim plugins(wakatime & copilot)
        ".wakatime"
        ".config/github-copilot"

        ".trash"
        "Notes"
        "Zotero"
        "KiCad"
      ];
      files = [
        ".wakatime.cfg"
        ".config/nushell/history.txt"
      ];
    };
  };
}
