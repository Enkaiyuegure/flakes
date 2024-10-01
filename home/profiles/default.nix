{ inputs, withSystem, homeModules, myvars, ... }:
let
  homeImports = {
    "${myvars.username}@ltp-zbook-nix" = [ ./ltp-zbook-nix ] ++ homeModules;
    "${myvars.username}@tower-qtj1-nix" = [ ./tower-qtj1-nix ] ++ homeModules;
    "${myvars.username}@router-n100-nix" = [ ./router-n100-nix ] ++ homeModules;
  };

  inherit (inputs.home-manager.lib) homeManagerConfiguration;
in
{
  imports = [
    { _module.args = { inherit homeImports; }; }
  ];

  flake = {
    homeConfigurations = withSystem "x86_64-linux" ({ pkgs, ... }: {
      "${myvars.username}@ltp-zbook-nix" = homeManagerConfiguration {
        modules = homeImports."${myvars.username}@ltp-zbook-nix";
        inherit pkgs;
      };
      "${myvars.username}@tower-qtj1-nix" = homeManagerConfiguration {
        modules = homeImports."${myvars.username}@tower-qtj1-nix";
        inherit pkgs;
      };
      "${myvars.username}@router-n100-nix" = homeManagerConfiguration {
        modules = homeImports."${myvars.username}@router-n100-nix";
        inherit pkgs;
      };
    });
  };
}
