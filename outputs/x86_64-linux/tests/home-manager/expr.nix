{
  myVars,
  lib,
  outputs,
}: let
  username = myVars.username;
  hosts = [
    "desktop-dashao-xorg-gnome-mutter"
    "desktop-dashao-xorg-kde-kwin"
    "desktop-dashao-wayland-none-hyprland"
  ];
in
  lib.genAttrs
  hosts
  (
    name: outputs.nixosConfigurations.${name}.config.home-manager.users.${username}.home.homeDirectory
  )
