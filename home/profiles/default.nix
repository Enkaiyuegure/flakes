{ inputs, withSystem, homeModules, myVars, ... }:
let
  homeImports = {
    "${myVars.userName}@ltp-zbook-nix" = [ ./ltp-zbook-nix ] ++ homeModules;
    "${myVars.userName}@tower-qtj1-nix" = [ ./tower-qtj1-nix ] ++ homeModules;
    "${myVars.userName}@router-n100-nix" = [ ./router-n100-nix ] ++ homeModules;
  };

  inherit (inputs.home-manager.lib) homeManagerConfiguration;
in
{
  imports = [
    { _module.args = { inherit homeImports; }; }
  ];

  flake = {
    homeConfigurations = withSystem "x86_64-linux" ({ pkgs, ... }: {
      "${myVars.userName}@ltp-zbook-nix" = homeManagerConfiguration {
        modules = homeImports."${myVars.userName}@ltp-zbook-nix";
        inherit pkgs;
      };
      "${myVars.userName}@tower-qtj1-nix" = homeManagerConfiguration {
        modules = homeImports."${myVars.userName}@tower-qtj1-nix";
        inherit pkgs;
      };
      "${myVars.userName}@router-n100-nix" = homeManagerConfiguration {
        modules = homeImports."${myVars.userName}@router-n100-nix";
        inherit pkgs;
      };
    });
  };
}
