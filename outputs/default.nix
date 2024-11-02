{ self
, nixpkgs
, flake-parts
, ...
} @ inputs:
let
  inherit (inputs.nixpkgs) lib;
  myLib = import ../lib { inherit lib; };
  myVars = import ../vars;
in
flake-parts.lib.mkFlake { inherit inputs; } {
  imports = [
    {
      _module.args = {
        inherit myVars;
        inherit myLib;
      };
    }
    ./x86_64-linux
  ];
  systems = [ "x86_64-linux" ];
  perSystem = { config, self', inputs', pkgs, system, ... }: {
  };
  flake = {
  };
}
