{ myVars, ... }:
{
  virtualisation.lxd.enable = true;
  users.users.${myVars.userName} = {
    extraGroups = [ "lxd" ];
  };
}
