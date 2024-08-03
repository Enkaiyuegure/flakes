{ userName, ... }:
{
  virtualisation.lxd.enable = true;
  users.users.${userName} = {
    extraGroups = [ "lxd" ];
  };
}
