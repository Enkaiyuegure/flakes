{ inputs, hostModules, homeImports, myVars, myLib, ... }:
{
  flake.nixosConfigurations =
    let
      packages.x86_64-linux.default = inputs.nixpkgs.legacyPackages.x86_64-linux.callPackage ../../pkgs/ags { inherit inputs; };
      inherit (inputs.nixpkgs.lib) nixosSystem;
    in
    {
      "ltp-zbook-nix" = nixosSystem rec{
        specialArgs = {
          inherit myVars myLib;
          asztal = packages.x86_64-linux.default;
        };
        modules = [
          ./ltp-zbook-nix
          {
            home-manager = {
              backupFileExtension = "backup";
              extraSpecialArgs = inputs;
              users.${myVars.userName}.imports = homeImports."${myVars.userName}@ltp-zbook-nix";
            };
          }
        ] ++ hostModules;
      };
      "tower-qtj1-nix" = nixosSystem {
        specialArgs = { inherit myVars; };
        modules = [
          ./tower-qtj1-nix
          {
            home-manager = {
              backupFileExtension = "backup";
              extraSpecialArgs = inputs;
              users.${myVars.userName}.imports = homeImports."${myVars.userName}@tower-qtj1-nix";
            };
          }
        ] ++ hostModules;
      };
      "router-n100-nix" = nixosSystem {
        specialArgs = { inherit myVars; };
        modules = [
          ./router-n100-nix
          {
            home-manager = {
              backupFileExtension = "backup";
              extraSpecialArgs = inputs;
              users.${myVars.userName}.imports = homeImports."${myVars.userName}@router-n100-nix";
            };
          }
        ] ++ hostModules;
      };

    };
}
