{ self, inputs, lib, ... }:
let
  #system-agnostic args
  module_args._module.args = {
    inherit inputs self;
  };

  mylib = import ../../lib;
  myvars = import ../vars { inherit lib; };
in
{
  imports = [
    {
      _module.args = {
        inherit module_args;
        inherit myvars;
        inherit mylib;

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
          ./core.nix
          ./hosts
          ./nix.nix
        ];

        #HomeManager modules
        homeModules = [
          (import ./home { inherit myvars mylib; })
          module_args
          inputs.anyrun.homeManagerModules.anyrun
          inputs.ags.homeManagerModules.default
        ];
      };
    }
  ];
  flake.nixosModules = { };
}
