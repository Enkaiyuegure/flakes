{ pkgs, myvars, ... }:
{
  virtualisation = {
    docker.enable = true;
  };

  users.groups.docker.members = [ "${myvars.username}" ];

  environment.systemPackages = with pkgs; [
    docker-compose
  ];
}
