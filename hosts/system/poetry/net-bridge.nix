{
  networking.useDHCP = false;
  networking.bridges = {
    "br0" = {
      interfaces = [ "enp4s0" ];
    };
  };
  networking.interfaces.br0.ipv4.addresses = [ {
    address = "10.10.250.1";
    prefixLength = 16;
  } ];
  networking.defaultGateway = "10.10.1.1";
  networking.nameservers = ["10.10.1.1" "8.8.8.8"];
}
