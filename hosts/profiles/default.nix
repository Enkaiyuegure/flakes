{ inputs, ... }:
{
  flake.nixosConfigurations = {
    "ltp-zbook-nix" = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        inputs.disko.nixosModules.disko
        inputs.impermanence.nixosModules.impermanence

        ../../modules/hosts/dae.nix
        ../../lib/disko_layout/ltp-zbook-nix.nix
        ../../modules/hosts/impermanence.nix

        ../ltp/zbook

	inputs.home-manager.nixosModules.home-manager
	{
	  home-manager = {
	    useGlobalPkgs = true;
	    useUserPackages = true;
	    extraSpecialArgs = inputs;
	    users.enkai = import ../../home;
	  };
	}
      ];
    };
  "tower-qtj1-nix" = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    modules = [

    ];
  };

  };
}
