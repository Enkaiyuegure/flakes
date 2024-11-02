{ inputs, ... }:
{
  flake.nixosConfigurations."dashao" = inputs.nixpkgs.lib.nixosSystem rec{
    modules = [
      ./configuration.nix
      ./dae.nix
      inputs.disko.nixosModules.disko
      inputs.impermanence.nixosModules.impermanence
    ];
  };
}
