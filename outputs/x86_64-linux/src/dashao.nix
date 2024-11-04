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
      "hosts/dashao"
      "dae.nix"
      "gnome.nix"
    ] ++ (with inputs; [
      disko.nixosModules.disko
      impermanence.nixosModules.impermanence 
    ]);
    home-modules = map myLib.relativeToRoot [
    ];
  };

  modules = {
    nixos-modules = base-modules.nixos-modules;
    home-modules = base-modules.home-modules;
  };
in {
  nixosConfigurations = {
    # host with hyprland compositor
    "${name}" = myLib.nixosSystem (modules // args);
  };

  # generate iso image for hosts with desktop environment
  packages = {
    "${name}" = inputs.self.nixosConfigurations."${name}".config.formats.iso;
  };
}
