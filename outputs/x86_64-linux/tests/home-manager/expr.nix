{
  myVars,
  lib,
  outputs,
}: let
  username = myVars.username;
  hosts = [
    "dashao-xorg-gnome-mutter"
    "dashao-xorg-kde-kwin"
    "dashao-wayland-none-hyprland"
  ];
in
  lib.genAttrs
  hosts
  (
    name: outputs.nixosConfigurations.${name}.config.home-manager.users.${username}.home.homeDirectory
  )
