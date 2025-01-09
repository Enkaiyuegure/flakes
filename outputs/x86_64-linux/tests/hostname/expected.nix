{
  lib,
  outputs,
}: let
  specialExpected = {
    "desktop-wu-xorg-gnome-mutter" = "wu";
    "desktop-wu-xorg-kde-kwin" = "wu";
    "desktop-wu-wayland-none-hyprland" = "wu";
    "desktop-wu-wayland-none-gamescope" = "wu";
  };
  specialHostNames = builtins.attrNames specialExpected;

  otherHosts = builtins.removeAttrs outputs.nixosConfigurations specialHostNames;
  otherHostsNames = builtins.attrNames otherHosts;
  # other hosts's hostName is the same as the nixosConfigurations name
  otherExpected = lib.genAttrs otherHostsNames (name: name);
in (specialExpected // otherExpected)
