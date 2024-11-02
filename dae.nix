{ pkgs, ... }:
{
  services.dae = {
    enable = true;
    package = pkgs.dae;
    # NOTE: use absolute paths!
    configFile = "/home/enkai/config.dae";
    disableTxChecksumIpGeneric = false;
    assets = with pkgs; [ v2ray-geoip v2ray-domain-list-community ];
  };
  # manual launch(geoip.dat,geosite.dat,config.dae needs to be in the same directory): 
  # `wget https://cdn.jsdelivr.net/gh/Loyalsoldier/geoip@release/geoip.dat`
  # `wget wget https://cdn.jsdelivr.net/gh/Loyalsoldier/v2ray-rules-dat@release/geosite.dat`
  # `dae run --disable-timestamp -c /path/to/config.dae`
}
