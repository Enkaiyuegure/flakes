{
  myVars,
  lib,
}: let
  username = myVars.username;
  hosts = [
    "dashao"
  ];
in
  lib.genAttrs hosts (_: "/home/${username}")
