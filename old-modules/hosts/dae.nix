{ pkgs, ... }:
{
  services.dae = {
    enable = true;

    openFirewall = {
      enable = true;
      port = 12345;
    };

    package = pkgs.dae;

    configFile = "/var/lib/config.dae";
    disableTxChecksumIpGeneric = false;
    assets = with pkgs; [ v2ray-geoip v2ray-domain-list-community ];
  };
}
