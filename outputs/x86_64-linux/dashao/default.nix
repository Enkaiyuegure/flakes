{ inputs, myLib, myVars, ... }:
{
  flake.nixosConfigurations."dashao" = inputs.nixpkgs.lib.nixosSystem rec{
    modules = (map myLib.relativeToRoot [
      "configuration.nix"
      "dae.nix"
      "gnome.nix"
    ])
    ++ [
      {
        _module.args = {
          inherit myVars;
          inherit myLib;
        };
      }  
      inputs.disko.nixosModules.disko
      inputs.impermanence.nixosModules.impermanence
    ];
  };
}
