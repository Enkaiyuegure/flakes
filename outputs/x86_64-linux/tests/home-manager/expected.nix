{
  myVars,
  lib,
}: let
  username = myVars.username;
  hosts = [
    "dashao-xorg-gnome-mutter"
    "dashao-xorg-kde-kwin"
    "dashao-wayland-none-hyprland"
  ];
in
  lib.genAttrs hosts (_: "/home/${username}")
