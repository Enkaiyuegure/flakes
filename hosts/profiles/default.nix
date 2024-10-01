{ inputs, hostModules, homeImports, myvars, mylib, ... }:
{
  flake.nixosConfigurations =
    let
      packages.x86_64-linux.default = inputs.nixpkgs.legacyPackages.x86_64-linux.callPackage ../../pkgs/ags { inherit inputs; };
      inherit (inputs.nixpkgs.lib) nixosSystem;
    in
    {
      "ltp-zbook-nix" = nixosSystem rec{
        specialArgs = {
          inherit myvars mylib;
          asztal = packages.x86_64-linux.default;
        };
        modules = [
          ./ltp-zbook-nix
          {
            home-manager = {
              backupFileExtension = "backup";
              extraSpecialArgs = inputs;
              users.${myvars.username}.imports = homeImports."${myvars.username}@ltp-zbook-nix";
            };
          }
        ] ++ hostModules;
      };
      "tower-qtj1-nix" = nixosSystem {
        specialArgs = { inherit myvars; };
        modules = [
          ./tower-qtj1-nix
          {
            home-manager = {
              backupFileExtension = "backup";
              extraSpecialArgs = inputs;
              users.${myvars.username}.imports = homeImports."${myvars.username}@tower-qtj1-nix";
            };
          }
        ] ++ hostModules;
      };
      "router-n100-nix" = nixosSystem {
        specialArgs = { inherit myvars; };
        modules = [
          ./router-n100-nix
          {
            home-manager = {
              backupFileExtension = "backup";
              extraSpecialArgs = inputs;
              users.${myvars.username}.imports = homeImports."${myvars.username}@router-n100-nix";
            };
          }
        ] ++ hostModules;
      };

    };
}
