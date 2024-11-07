{
  # NOTE: the args not used in this file CAN NOT be removed!
  # because haumea pass argument lazily,
  # and these arguments are used in the functions like `myLib.nixosSystem`, `myLib.colmenaSystem`, etc.
  inputs,
  lib,
  myVars,
  myLib,
  system,
  genSpecialArgs,
  ...
} @ args: let
  name = "dashao";
  base-modules = {
    nixos-modules = map myLib.relativeToRoot [
      "hosts/system/${name}"
      "modules/nixos/desktop.nix"
      "dae.nix"
      "hardening/nixpaks"
    ];
    home-modules = map myLib.relativeToRoot [
      "hosts/user/${name}"
      "home/linux/gui.nix"
    ];
  };

  modules-xorg-gnome = {
    nixos-modules = 
      [
        {
          modules.nixos.desktop.xorg.enable = true;
          modules.nixos.desktop.de.gnome.enable = true;
        }
      ]
      ++ base-modules.nixos-modules;
    home-modules = 
      [
        {
          home.linux.gui.gnome.enable = true;
        }
      ]
      ++ base-modules.home-modules;
  };

  modules-wayland-hyprland = {
    nixos-modules = 
      [
        {
          modules.nixos.desktop.wayland.enable = true;
        }
      ]
      ++ base-modules.nixos-modules;
    home-modules = 
      [
        {
          home.linux.gui.hyprland.enable = true;
        }
      ]
      ++ base-modules.home-modules;
  };
in {
  nixosConfigurations = {
    # host with hyprland compositor
    "${name}-xorg-gnome" = myLib.nixosSystem (modules-xorg-gnome // args);
    "${name}-wayland-hyprland" = myLib.nixosSystem (modules-wayland-hyprland // args);
  };

  # generate iso image for hosts with desktop environment
  packages = {
    "${name}-xorg-gnome" = inputs.self.nixosConfigurations."${name}-xorg-gnome".config.formats.iso;
    "${name}-wayland-hyprland" = inputs.self.nixosConfigurations."${name}-wayland-hyprland".config.formats.iso;
  };
}
