{ inputs, hostModules, homeImports, userName, ... }:
{
  flake.nixosConfigurations =
    let
      inherit (inputs.nixpkgs.lib) nixosSystem;
    in
    {
      "ltp-zbook-nix" = nixosSystem {
        specialArgs = { inherit userName; };
        modules = [
          ./ltp-zbook-nix

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
      "tower-qtj1-nix" = nixosSystem {
        modules = [
        ];
      };
    };
}
