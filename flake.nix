{
  description = "Nix Flakes Configuration of Enkaiyuegure";

  outputs = inputs @ { self, ... }: inputs.flake-parts.lib.mkFlake { inherit inputs; } {
    debug = true;
    flake = {
      
    };
    imports = [
      ./hosts
    ];
    systems = [
      "x86_64-linux"
    ];
    perSystem = { config, ... }: {

    };
  };

  inputs = {
    #-- nixpkgs -- Nix packages collection & NixOS
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    #-- home-manager -- Manage a user environment using Nix
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #-- flake-parts -- Simplify Nix Flakes with the module system
    flake-parts.url = "github:hercules-ci/flake-parts";
    #-- flake-root -- A `flake-parts` module for finding your way to the project root directory
    flake-root.url = "github:srid/flake-root";

    #-- disko -- Declarative disk partitioning and formatting using nix
    disko.url = "github:nix-community/disko";
    #-- impermanence -- Modules to help you handle persistent state on systems with ephemeral root storage
    impermanence.url = "github:nix-community/impermanence";
  };

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
    ];
    trusted-users = [ "root" "@wheel" ];
  };
}
