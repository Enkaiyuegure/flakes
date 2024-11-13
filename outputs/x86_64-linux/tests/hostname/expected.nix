{
  lib,
  outputs,
}: let
  specialExpected = {
    "desktop-dashao-xorg-gnome-mutter" = "dashao";
    "desktop-dashao-xorg-kde-kwin" = "dashao";
    "desktop-dashao-wayland-none-hyprland" = "dashao";
    "desktop-dashao-wayland-none-gamescope" = "dashao";
  };
  specialHostNames = builtins.attrNames specialExpected;

  otherHosts = builtins.removeAttrs outputs.nixosConfigurations specialHostNames;
  otherHostsNames = builtins.attrNames otherHosts;
  # other hosts's hostName is the same as the nixosConfigurations name
  otherExpected = lib.genAttrs otherHostsNames (name: name);
in (specialExpected // otherExpected)
