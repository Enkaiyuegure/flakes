{ pkgs, myVars, ... }:
{
  virtualisation = {
    docker.enable = true;
  };

  users.groups.docker.members = [ "${myVars.userName}" ];

  environment.systemPackages = with pkgs; [
    docker-compose
  ];
}
