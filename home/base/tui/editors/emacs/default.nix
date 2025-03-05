{
  config,
  lib,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    emacs-pkg
  ];
}
