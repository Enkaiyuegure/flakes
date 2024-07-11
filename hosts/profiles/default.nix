{ inputs, hostModules, homeImports, userName, ... }:
{
  flake.nixosConfigurations = {
    "ltp-zbook-nix" = inputs.nixpkgs.lib.nixosSystem {
      specialArgs = { inherit userName; };
      modules = [
        ./ltp/zbook

        ../../modules/hosts/dae.nix
        ../../lib/disko_layout/ltp-zbook-nix.nix
        ../../modules/hosts/impermanence.nix

        {
          home-manager = {
            extraSpecialArgs = inputs;
            users.${userName}.imports = homeImports."${userName}@ltp-zbook-nix";
          };
        }
      ] ++ hostModules;
    };
    "tower-qtj1-nix" = inputs.nixpkgs.lib.nixosSystem {
      modules = [
      ];
    };
  };
}
