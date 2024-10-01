{ myvars, ... }:
{
  virtualisation.lxd.enable = true;
  users.users.${myvars.username} = {
    extraGroups = [ "lxd" ];
  };
}
