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
          {
            home-manager = {
              extraSpecialArgs = inputs;
              users.${userName}.imports = homeImports."${userName}@ltp-zbook-nix";
            };
          }
        ] ++ hostModules;
      };
      "tower-qtj1-nix" = nixosSystem {
        specialArgs = { inherit userName; };
        modules = [
          ./tower-qtj1-nix
          {
            home-manager = {
              extraSpecialArgs = inputs;
              users.${userName}.imports = homeImports."${userName}@tower-qtj1-nix";
            };
          }
        ] ++ hostModules;
      };
      "router-n100-nix" = nixosSystem {
        specialArgs = { inherit userName; };
        modules = [
          ./router-n100-nix
          {
            home-manager = {
              extraSpecialArgs = inputs;
              users.${userName}.imports = homeImports."${userName}@router-n100-nix";
            };
          }
        ] ++ hostModules;
      };

    };
}
