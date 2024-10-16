{
  description = "Nix Flakes Configuration of Enkaiyuegure";

  outputs = inputs: import ./outputs inputs;

  inputs = {
    ##########################################systemBase###########################################
    #================================Nix Packages collection & NixOS==============================#
    #-----------Official NixOS package source, using nixos's unstable branch by default-----------#
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable-small";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.05";
    #=============================Manage a user environment using Nix=============================#
    #---------------------home-manager, used for managing user configuration----------------------#
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #===================================Secure Boot for NixOS=====================================#
    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #===================Declarative disk partitioning and formatting using nix====================#
    disko = {
      url = "github:nix-community/disko/v1.6.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #======Modules to help you handle persistent state on systems with ephemeral root storage=====#
    impermanence.url = "github:nix-community/impermanence";
    ######################################desktopEnvironment#######################################
    #=============================A customizable and extensible shell=============================#
    ags.url = "github:Aylur/ags";
    #=============================A material you color generation tool============================#
    matugen.url = "github:InioX/matugen?ref=v2.2.0";
    #==========JS/TS framework for creating Linux Desktops ontop of Wayland compositors===========#
    astal.url = "github:Aylur/astal";
    #=========================================myWallpapers========================================#
    wallpapers = {
      url = "github:Enkaiyuegure/wallpapers";
      flake = false;
    };
    #########################################systemTools###########################################
    #=================================Collection of image builders================================#
    #----------------generate iso/qcow2/docker/... image from nixos configuration-----------------#
    nixos-generators = {
      url = "github:nix-community/nixos-generators";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #===============age-encrypted secrets for NixOS; drop-in replacement for agenix===============#
    agenix = {
      url = "github:yaxitech/ragenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #==============================The Proxmox Hypervisor, on NixOS#==============================#
    proxmox-nixos.url = "github:SaumonNet/proxmox-nixos";
    #######################################othersNixProject########################################
    #================================A Nushell environment for Nix================================#
    nuenv.url = "github:DeterminateSystems/nuenv";
    #=========================================Gaming on Nix=======================================#
    nix-gaming.url = "github:fufexan/nix-gaming";
    #======================Nix User Repository: User contributed nix packages=====================#
    nur.url = "github:nix-community/NUR";
    #==============================Weekly updated nix-index database==============================#
    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #=============Seamless integration of https://pre-commit.com git hooks with Nix.==============#
    #------------------------add git hooks to format nix code before commit-----------------------#
    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #============================Filesystem-based module system for Nix===========================#
    haumea = {
      url = "github:nix-community/haumea/v0.2.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #=========================#Nix language server, based on nix libraries========================#
    nixd.url = "github:nix-community/nixd";
    #===================================treefmt nix configuration=================================#
    treefmt-nix.url = "github:numtide/treefmt-nix";
    #############################################end###############################################
    #-- flake-parts -- Simplify Nix Flakes with the module system
    flake-parts.url = "github:hercules-ci/flake-parts";
    #-- flake-root -- A `flake-parts` module for finding your way to the project root directory
    flake-root.url = "github:srid/flake-root";
    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-registry = {
      url = "github:NixOS/flake-registry";
      flake = false;
    };
    nvim-flake.url = "github:Ruixi-rebirth/nvim-flake";
  };

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://cache.saumon.network/proxmox-nixos"
      "https://nix-gaming.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "proxmox-nixos:nveXDuVVhFDRFx8Dn19f1WDEaNRJjPrF2CPD2D+m1ys="
      "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
    ];
    trusted-users = [ "root" "@wheel" ];
  };
}
