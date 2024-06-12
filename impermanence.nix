{
  environment = {
    persistence."/persist" = {
      directories = [
        "/etc/nixos" # bind mounted from /persist/etc/nixos to /etc/nixos
        "/etc/NetworkManager/system-connections"
        "/var/log"
        "/var/lib"
        "/etc/secureboot"
      ];
      files = [
        "/etc/machine-id"
        "/etc/create-ap.conf"
      ];
    };
  };
}
