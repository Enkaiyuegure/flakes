{ self, inputs, ... }:
let
  #system-agnostic args
  module_args._module.args = {
    inherit inputs self;
  };

  myLib = import ../lib;
  myVars = import ../vars;
in
{
  imports = [
    {
      _module.args = {
        inherit module_args;
        inherit myVars;
        inherit myLib;

        #NixOS modules
        hostModules = [
          inputs.home-manager.nixosModule
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
            };
          }
          inputs.disko.nixosModules.disko
          inputs.impermanence.nixosModules.impermanence
          inputs.proxmox-nixos.nixosModules.proxmox-ve

          module_args
          ./system.nix
          ./hosts
          ./core.nix
          ./nix.nix
        ];

        #HomeManager modules
        homeModules = [
          (import ./home { inherit myVars myLib; })
          module_args
          inputs.anyrun.homeManagerModules.anyrun
          inputs.ags.homeManagerModules.default
        ];
      };
    }
  ];
  flake.nixosModules = { };
}
