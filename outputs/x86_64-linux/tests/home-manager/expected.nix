{
  myVars,
  lib,
}: let
  username = myVars.username;
  hosts = [
    "desktop-dashao-xorg-gnome-mutter"
    "desktop-dashao-xorg-kde-kwin"
    "desktop-dashao-wayland-none-hyprland"
    "desktop-dashao-wayland-none-gamescope"
  ];
in
  lib.genAttrs hosts (_: "/home/${username}")
