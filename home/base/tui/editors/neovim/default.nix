{
  config,
  lib,
  pkgs,
  pkgs-unstable,
  ...
}:
{
  programs.neovim.nvimdots = {
    enable = true;
    setBuildEnv = true;  # Only needed for NixOS
    withBuildTools = true; # Only needed for NixOS
    #bindLazyLock=true; # place lazy-lock.json under nix management to ensure reproducibility
    mergeLazyLock=true; # allow changes using lazy.nvim while still managing versions
    withHaskell = true; # If you want to use Haskell.
    extraHaskellPackages = hsPkgs: []; # Configure packages for Haskell (nixpkgs.haskellPackages).
    extraDependentPackages = with pkgs; []; # Properly setup the directory hierarchy (`lib`, `include`, and `pkgconfig`).
  };
}
