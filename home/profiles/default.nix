{ inputs, withSystem, module_args, ... }:
let
  userName = "enkai";

  homeModules = [
    (import ../. { inherit userName; })
    module_args
  ];

  homeImports = {
    "${userName}@ltp-zbook-nix" = [ ./ltp-zbook-nix ] ++ homeModules;
  };

  inherit (inputs.home-manager.lib) homeManagerConfiguration;
in
{
  imports = [
    { _module.args = { inherit homeImports userName; }; }
  ];

  flake = {
    homeConfigurations = withSystem "x86_64-linux" ({ pkgs, ... }: {
      "${userName}@ltp-zbook-nix" = homeManagerConfiguration {
        modules = homeImports."${userName}@ltp-zbook-nix";
        inherit pkgs;
      };
    });
  };
}
