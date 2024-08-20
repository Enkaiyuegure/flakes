{ self, inputs, ... }:
let
  #system-agnostic args
  module_args._module.args = {
    inherit inputs self;
  };

  userName = "enkai";
in
{
  imports = [
    {
      _module.args = {
        inherit module_args;
        inherit userName;

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
          (import ./home { inherit userName; })
          module_args
          inputs.anyrun.homeManagerModules.anyrun
          inputs.ags.homeManagerModules.default
        ];
      };
    }
  ];
  flake.nixosModules = { };
}
