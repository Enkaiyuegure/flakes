{ inputs, withSystem, homeModules, userName, ... }:
let
  homeImports = {
    "${userName}@ltp-zbook-nix" = [ ./ltp-zbook-nix ] ++ homeModules;
    "${userName}@tower-qtj1-nix" = [ ./tower-qtj1-nix ] ++ homeModules;
  };

  inherit (inputs.home-manager.lib) homeManagerConfiguration;
in
{
  imports = [
    { _module.args = { inherit homeImports; }; }
  ];

  flake = {
    homeConfigurations = withSystem "x86_64-linux" ({ pkgs, ... }: {
      "${userName}@ltp-zbook-nix" = homeManagerConfiguration {
        modules = homeImports."${userName}@ltp-zbook-nix";
        inherit pkgs;
      };
      "${userName}@tower-qtj1-nix" = homeManagerConfiguration {
        modules = homeImports."${userName}@tower-qtj1-nix";
        inherit pkgs;
      };
    });
  };
}
