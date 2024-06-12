{
  description = "Nix Flakes Configuration of Enkaiyuegure";

  outputs = inputs @ { self, ... }: {
    nixosConfigurations."ltp-zbook-nix" = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        inputs.disko.nixosModules.disko
        inputs.impermanence.nixosModules.impermanence

        ./dae.nix
        ./ltp-zbook-nix.nix
        ./impermanence.nix

	./configuration.nix
      ];
    };
  };

  inputs = {
    #-- nixpkgs -- Nix packages collection & NixOS
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
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
