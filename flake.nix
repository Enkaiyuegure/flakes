{
  description = "Nix Flakes Configuration of Enkaiyuegure";

  inputs = {
    ##########################################systemBase###########################################
    #================================Nix Packages collection & NixOS==============================#
    #-----------Official NixOS package source, using nixos's unstable branch by default-----------#
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    #-------------------------Simplify Nix Flakes with the module system--------------------------#
    flake-parts.url = "github:hercules-ci/flake-parts";
    #===================Declarative disk partitioning and formatting using nix====================#
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #======Modules to help you handle persistent state on systems with ephemeral root storage=====#
    impermanence.url = "github:nix-community/impermanence";
    #############################################end###############################################
  };

  outputs = inputs@{ flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
        ./dashao.nix
      ];
      systems = [ "x86_64-linux" ];
      perSystem = { config, self', inputs', pkgs, system, ... }: {
      };
      flake = {
      };
    };
}
