{
  environment = {
    persistence = {
      "/persist" = {
        directories = [
          "/etc/nixos"
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
      "/.secret" = {
        users.enkai = {
          directories = [
            { directory = ".gnupg"; mode = "0700"; }
            { directory = ".ssh"; mode = "0700"; }
          ];
          files = [
          ];
        };
      };
    };
  }; 
}
