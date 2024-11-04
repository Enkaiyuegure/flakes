{
  myVars,
  lib,
  outputs,
}: let
  username = myVars.username;
  hosts = [
    "dashao"
  ];
in
  lib.genAttrs
  hosts
  (
    name: outputs.nixosConfigurations.${name}.config.home-manager.users.${username}.home.homeDirectory
  )
