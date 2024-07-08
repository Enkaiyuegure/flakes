{ self, inputs, user, ... }:
let
  #system-agnostic args
  module_args._module.args = {
    inherit inputs self;
  };
in
{
  imports = [
    {
      _module.args = {
        inherit module_args;

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
          module_args
          ./system.nix
          ./i3.nix
        ];
      };
    }
  ];
  flake.nixosModules = {

  };
}
