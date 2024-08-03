{ pkgs, userName, ... }:
{
  virtualisation = {
    docker.enable = true;
  };

  users.groups.docker.members = [ "${userName}" ];

  environment.systemPackages = with pkgs; [
    docker-compose
  ];
}
