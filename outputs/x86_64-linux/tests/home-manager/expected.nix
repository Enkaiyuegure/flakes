{
  myVars,
  lib,
}: let
  username = myVars.username;
  hosts = [
    "desktop-wu-xorg-gnome-mutter"
    "desktop-wu-xorg-kde-kwin"
    "desktop-wu-wayland-none-hyprland"
    "desktop-wu-wayland-none-gamescope"
  ];
in
  lib.genAttrs hosts (_: "/home/${username}")
