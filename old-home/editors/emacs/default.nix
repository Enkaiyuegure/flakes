{ config, pkgs, callPackage, ... }:
{
  # ...

  services.emacs = {
    enable = true;
    package = pkgs.emacs-unstable;
  };

  nixpkgs.overlays = [
    (import (builtins.fetchTarball {
      url = "https://github.com/nix-community/emacs-overlay/archive/master.tar.gz";
      sha256 = "1m4fprq2shsab7dwv1d6n9c83n89hjd21kbjbzz2rf4pqyfi8yc3";
    }))
  ];

  # ...
}
