{
  description = "Nix Flakes Configuration of Enkaiyuegure";

  inputs = {
    ##########################################systemBase###########################################
    #================================Nix Packages collection & NixOS==============================#
    #-----------Official NixOS package source, using nixos's unstable branch by default-----------#
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable-small";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    #===========================================nixlib============================================#
    nixlib.url = "github:nix-community/nixpkgs.lib";
    #================A modern, delicious implementation of the Nix package manager================#
    lix = {
      url = "https://git.lix.systems/lix-project/lix/archive/main.tar.gz";
      flake = false;
    };
    lix-module = {
      url = "git+https://git.lix.systems/lix-project/nixos-module";
      inputs = {
        lix.follows = "lix";
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
        flakey-profile.follows = "flakey-profile";
      };
    };
    #=========================Simplify Nix Flakes with the module system==========================#
    flake-parts.url = "github:hercules-ci/flake-parts";
    #==========A `flake-parts` module for finding your way to the project root directory==========#
    flake-root.url = "github:srid/flake-root";
    #===============================Pure Nix flake utility functions==============================#
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };
    #===A collection of NixOS modules covering hardware quirks===#
    nixos-hardware.url = "github:NixOS/nixos-hardware";
    #=============================Manage a user environment using Nix=============================#
    #---------------------home-manager, used for managing user configuration----------------------#
    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #===================================nix modules for darwin====================================#
    darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #=================================NixOS profiles for servers==================================#
    srvos = {
      url = "github:nix-community/srvos";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #========================Nix-enabled environment for your Android device======================#
    nix-on-droid = {
      url = "github:nix-community/nix-on-droid";
      inputs = {
        home-manager.follows = "home-manager";
        nixpkgs.follows = "nixpkgs";
      };
    };
    #===================================Secure Boot for NixOS=====================================#
    lanzaboote = {
      url = "github:nix-community/lanzaboote";
      inputs = {
        flake-compat.follows = "flake-compat";
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        pre-commit-hooks-nix.follows = "pre-commit-hooks";
      };
    };
    #===================Declarative disk partitioning and formatting using nix====================#
    disko = {
      url = "github:nix-community/disko/v1.6.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #======Modules to help you handle persistent state on systems with ephemeral root storage=====#
    impermanence.url = "github:nix-community/impermanence";
    ######################################desktopEnvironment#######################################
    #============================Manage KDE Plasma with Home Manager==============================#
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
    #========================================Hyprland=============================================#
    #-----------an independent, highly customizable, dynamic tiling Wayland compositor------------# 
    #-----------------------------that doesn't sacrifice on its looks-----------------------------#
    hyprland = {
      url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
        pre-commit-hooks.follows = "pre-commit-hooks";
      };
    };
    #================================Official plugins for Hyprland================================#
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs = {
        hyprland.follows = "hyprland";
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
      };
    };
    #===========================Workspace overview plugin for Hyprland============================#
    hyprland-hyprspace = {
      url = "github:KZDKM/Hyprspace";
      inputs = {
        hyprland.follows = "hyprland";
        systems.follows = "systems";
      };
    };
    #=============================A customizable and extensible shell=============================#
    ags = {
      url = "github:Aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #=============================A material you color generation tool============================#
    matugen = {
      url = "github:InioX/matugen?ref=v2.2.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #==========JS/TS framework for creating Linux Desktops ontop of Wayland compositors===========#
    astal = {
      url = "github:Aylur/astal";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #=========================A wayland native, highly customizable runner========================#
    anyrun = {
      url = "github:Kirottu/anyrun";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        systems.follows = "systems";
        flake-parts.follows = "flake-parts";
      };
    };
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
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nixlib.follows = "nixlib";
      };
    };
    #===============age-encrypted secrets for NixOS; drop-in replacement for agenix===============#
    agenix = {
      url = "github:yaxitech/ragenix";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
        rust-overlay.follows = "rust-overlay";
        crane.follows = "crane";
      };
    };
    #=====================Atomic secret provisioning for NixOS based on sops======================#
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #==============================The Proxmox Hypervisor, on NixOS#==============================#
    proxmox-nixos = {
      url = "github:SaumonNet/proxmox-nixos";
      inputs = {
        nixpkgs-stable.follows = "nixpkgs-stable";
        nixpkgs-unstable.follows = "nixpkgs";
        utils.follows = "flake-utils";
        flake-compat.follows = "flake-compat";
      };
    };
    #######################################othersNixProject########################################
    #================================A Nushell environment for Nix================================#
    nuenv = {
      url = "github:DeterminateSystems/nuenv";
      inputs.rust-overlay.follows = "rust-overlay";
    };
    #=========================================Gaming on Nix=======================================#
    nix-gaming = {
      url = "github:fufexan/nix-gaming";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
      };
    };
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
      url = "github:cachix/git-hooks.nix";
      inputs = {
        flake-compat.follows = "flake-compat";
        nixpkgs.follows = "nixpkgs";
      };
    };
    #============================Filesystem-based module system for Nix===========================#
    haumea = {
      url = "github:nix-community/haumea";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #==========================Nix language server, based on nix libraries========================#
    nixd = {
      url = "github:nix-community/nixd";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        flake-root.follows = "flake-root";
        treefmt-nix.follows = "treefmt-nix";
      };
    };
    #===================================treefmt nix configuration=================================#
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    #=================================Runtime sandboxing for Nix==================================#
    nixpak = {
      url = "github:nixpak/nixpak";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
      };
    };
    #=================================Global registry of Nix flakes===============================#
    flake-registry = {
      url = "github:NixOS/flake-registry";
      flake = false;
    };
    #============================Allow flakes to be used with Nix < 2.4===========================#
    flake-compat.url = "github:edolstra/flake-compat";
    #============================Declarative profiles with nix flakes=============================#
    flakey-profile.url = "github:lf-/flakey-profile";
    #==========================A simple multi-profile Nix-flake deploy tool=======================#
    deploy-rs = {
      url = "github:serokell/deploy-rs";
      inputs = {
        flake-compat.follows = "flake-compat";
        nixpkgs.follows = "nixpkgs";
        utils.follows = "flake-utils";
      };
    };
    #==================================Evaluate and build in parallel==============================#
    #------------------Combine the power of nix-eval-jobs with nix-output-monitor------------------# 
    #-----------------------to speed-up your evaluation and building process-----------------------#
    nix-fast-build = {
      url = "github:Mic92/nix-fast-build";
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        treefmt-nix.follows = "treefmt-nix";
      };
    };
    #=============================Externally extensible flake systems==============================#
    systems.url = "github:nix-systems/default";
    #===========================A Nix library for building cargo projects==========================#
    crane.url = "github:ipetkov/crane";
    #============Pure and reproducible nix overlay of binary distributed rust toolchains===========#
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ##############################################NUR##############################################
    nur-ryan4yin.url = "github:ryan4yin/nur-packages";
    ###########################################NonFlakes###########################################
    #==========================================DoomEmacs==========================================#
    #---------------------------a configuration framework for GNU Emacs---------------------------#
    doomemacs = {
      url = "github:Enkaiyuegure/doomemacs";
      flake = false;
    };
    #========someSource needed for Enkaiyuegure's Operation System-Related configurations=========#
    someSource = {
      url = "github:Enkaiyuegure/someSource";
      flake = false;
    };
    #===================Emacs support for direnv which operates buffer-locally====================#
    envrc = {
      url = "github:purcell/envrc";
      flake = false;
    };
    #############################################end###############################################
    emacs-overlay = {
      url = "github:nix-community/emacs-overlay";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        nixpkgs-stable.follows = "nixpkgs-stable";
      };
    };
    kickstart-nix-nvim = {
      url = "github:nix-community/kickstart-nix.nvim";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-utils.follows = "flake-utils";
      };
    };
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs = {
        nixpkgs.follows = "nixpkgs";
        flake-parts.follows = "flake-parts";
        git-hooks.follows = "pre-commit-hooks";
      };
    };
    nvimdots = {
      url = "github:Enkaiyuegure/nvimdots";
      inputs = {
        flake-parts.follows = "flake-parts";
        nixpkgs.follows = "nixpkgs";
        home-manager.follows = "home-manager";
      };
    };
  };

  nixConfig = {
    trusted-users = [ "root" "@wheel" ];
    extra-substituters = [
      "https://ryan4yin.cachix.org"
      "https://anyrun.cachix.org"
      "https://hyprland.cachix.org"
      "https://cache.lix.systems"
    ];
    extra-trusted-public-keys = [
      "ryan4yin.cachix.org-1:Gbk27ZU5AYpGS9i3ssoLlwdvMIh0NxG0w8it/cv9kbU="
      "anyrun.cachix.org-1:pqBobmOjI7nKlsUMV25u9QHa9btJK65/C8vnO3p346s="
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "cache.lix.systems:aBnZUw8zA7H35Cz2RyKFVs3H4PlGTLawyY5KRbvJR8o="
    ];
  };

  outputs = inputs: import ./outputs inputs;
}
