{ lib }: rec {
  mainGateway = "10.10.1.1"; # main router
  # use suzi as the default gateway
  # it's a subrouter with a transparent proxy
  defaultGateway = "10.10.1.2";
  nameservers = [
    "119.29.29.29" # DNSPod
    "223.5.5.5" # AliDNS
  ];
  prefixLength = 16;

  hostsAddr = {
    zbook = {
      # Primary Laptop
      iface = "enp2s0";
      ipv4 = "10.10.50.1";
    };
  };

  hostsInterface =
    lib.attrsets.mapAttrs
      (
        key: val: {
          interfaces."${val.iface}" = {
            useDHCP = false;
            ipv4.addresses = [
              {
                inherit prefixLength;
                address = val.ipv4;
              }
            ];
          };
        }
      )
      hostsAddr;

  ssh = {
    # define the host alias for remote builders
    # this config will be written to /etc/ssh/ssh_config
    # ''
    #   Host zbook
    #     HostName 10.10.50.1
    #     Port 22
    #   ...
    # '';
    extraConfig =
      lib.attrsets.foldlAttrs
        (acc: host: val:
          acc
          + ''
            Host ${host}
              HostName ${val.ipv4}
              Port 22
          '')
        ""
        hostsAddr;

    # define the host key for remote builders so that nix can verify all the remote builders
    # this config will be written to /etc/ssh/ssh_known_hosts
    knownHosts =
      # Update only the values of the given attribute set.
      #
      #   mapAttrs
      #   (name: value: ("bar-" + value))
      #   { x = "a"; y = "b"; }
      #     => { x = "bar-a"; y = "bar-b"; }
      lib.attrsets.mapAttrs
        (host: value: {
          hostNames = [ host hostsAddr.${host}.ipv4 ];
          publicKey = value.publicKey;
        })
        {
          zbook.publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIE7+CvR7E+SBRqyrDnpjM5VzbYJssQXCiP4araLoKbiG enkai@zbook";
        };
  };
}
