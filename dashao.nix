{ inputs, ... }:
{
  flake.nixosConfigurations."dashao" = inputs.nixpkgs.lib.nixosSystem rec{
    modules = [
      ./configuration.nix
      inputs.disko.nixosModules.disko
    ];
  };
}
