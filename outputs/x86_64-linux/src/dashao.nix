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
    nixos-modules = (map myLib.relativeToRoot [
      "hosts/system/${name}"
      "modules/nixos/desktop.nix"
      "modules/base/dae.nix"
      "hardening/nixpaks"
    ])
    ++ (with inputs; [
        disko.nixosModules.disko
        impermanence.nixosModules.impermanence 
        lix-module.nixosModules.default
    ]);
    home-modules = (map myLib.relativeToRoot [
      "hosts/user/${name}"
      "home/linux/gui.nix"
    ])
    ++ (with inputs; [
      plasma-manager.homeManagerModules.plasma-manager
    ]);
  };

  # modules-{protocol}-{de}-{wm}
  modules-xorg-gnome-mutter = {
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

  modules-wayland-none-hyprland = {
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

  modules-xorg-kde-kwin = {
    nixos-modules = 
      [
        {
          modules.nixos.desktop.xorg.enable = true;
          modules.nixos.desktop.de.kde.enable = true;
        }
      ]
      ++ base-modules.nixos-modules;
    home-modules = 
      [
        {
          home.linux.gui.kde.enable = true;
        }
      ]
      ++ base-modules.home-modules;
  };

in {
  nixosConfigurations = {
    # host with hyprland compositor
    "${name}-xorg-gnome-mutter" = myLib.nixosSystem (modules-xorg-gnome-mutter // args);
    "${name}-wayland-none-hyprland" = myLib.nixosSystem (modules-wayland-none-hyprland // args);
    "${name}-xorg-kde-kwin" = myLib.nixosSystem (modules-xorg-kde-kwin // args);
  };

  # generate iso image for hosts with desktop environment
  packages = {
    "${name}-xorg-gnome-mutter" = inputs.self.nixosConfigurations."${name}-xorg-gnome-mutter".config.formats.iso;
    "${name}-wayland-none-hyprland" = inputs.self.nixosConfigurations."${name}-wayland-none-hyprland".config.formats.iso;
    "${name}-xorg-kde-kwin" = inputs.self.nixosConfigurations."${name}-xorg-kde-kwin".config.formats.iso;
  };
}
