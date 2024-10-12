{ self
, nixpkgs
, pre-commit-hooks
, ...
} @ inputs:
let
  selfPkgs = import ../pkgs;
in
inputs.flake-parts.lib.mkFlake { inherit inputs; } {
  debug = true;
  flake = {
    overlays.default = selfPkgs.overlay;
  };
  imports = [
    ../old-hosts/profiles
    ../old-home/profiles
    ../old-modules
  ] ++ [
    inputs.flake-root.flakeModule
    inputs.treefmt-nix.flakeModule
  ];
  systems = [
    "x86_64-linux"
  ];
  perSystem = { config, pkgs, ... }: {
    treefmt.config = {
      inherit (config.flake-root) projectRootFile;
      package = pkgs.treefmt;
      programs = {
        nixpkgs-fmt.enable = true;
        prettier.enable = true;
        taplo.enable = true;
        shfmt.enable = true;
      };
    };

    devShells = {
      default = pkgs.mkShell {
        nativeBuildInputs = with pkgs; [ git neovim sbctl just ];
        inputsFrom = [
          config.flake-root.devShell
        ];
      };
    };

    formatter = config.treefmt.build.wrapper;

  };
}
