{flake-registry, nixpkgs, ...}:
{
  nix = {
    settings = {
      auto-allocate-uids = true;
      use-cgroups = true;
      accept-flake-config = false;
      flake-registry = "${flake-registry}/flake-registry.json";
      keep-derivations = true;
      keep-outputs = true;
   };

  # make `nix run nixpkgs#nixpkgs` use the same nixpkgs as the one used by this flake.
    registry.nixpkgs.flake = nixpkgs;
    extraOptions = ''
      keep-outputs            = true
      keep-derivations        = true
    '';
  };
}
