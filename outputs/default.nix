{ self
, nixpkgs
, flake-parts
, ...
} @ inputs:
flake-parts.lib.mkFlake { inherit inputs; } {
  imports = [
    ../dashao.nix
  ];
  systems = [ "x86_64-linux" ];
  perSystem = { config, self', inputs', pkgs, system, ... }: {
  };
  flake = {
  };
}
