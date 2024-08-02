{
  description = "Nix Flakes Configuration of Enkaiyuegure";

  outputs = inputs @ { self, ... }: inputs.flake-parts.lib.mkFlake { inherit inputs; } {
    debug = true;
    flake = { };
    imports = [
      ./hosts/profiles
      ./home/profiles
      ./modules
    ] ++ [
      inputs.flake-root.flakeModule
    ];
    systems = [
      "x86_64-linux"
    ];
    perSystem = { config, pkgs, ... }: {
      devShells = {
        default = pkgs.mkShell {
          nativeBuildInputs = with pkgs; [ git neovim sbctl just ];
          inputsFrom = [
            config.flake-root.devShell
          ];
        };
      };
    };
  };

  inputs = {
    #-- nixpkgs -- Nix packages collection & NixOS
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    #-- nixpkgs-stable -- Nix stable packages
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    #-- nixpkgs-unstable -- Nix unstable packages
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable-small";

    #-- home-manager -- Manage a user environment using Nix
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #-- flake-parts -- Simplify Nix Flakes with the module system
    flake-parts.url = "github:hercules-ci/flake-parts";
    #-- flake-root -- A `flake-parts` module for finding your way to the project root directory
    flake-root.url = "github:srid/flake-root";

    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    #-- disko -- Declarative disk partitioning and formatting using nix
    disko.url = "github:nix-community/disko";
    #-- impermanence -- Modules to help you handle persistent state on systems with ephemeral root storage
    impermanence.url = "github:nix-community/impermanence";
    flake-registry = {
      url = "github:NixOS/flake-registry";
      flake = false;
    };
    nur.url = "github:nix-community/NUR";
    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Add git hooks to format nix code before commit
    pre-commit-hooks.url = "github:cachix/pre-commit-hooks.nix";
    nvim-flake.url = "github:Ruixi-rebirth/nvim-flake";
    nixd.url = "github:nix-community/nixd";
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
