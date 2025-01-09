{ config, pkgs, myVars, ...}:
let
  inherit (myVars) username;
in
{
  programs = {
    nh = {
      enable = true;
      flake = "/home/${username}/Flakes";
    };
  };
}
