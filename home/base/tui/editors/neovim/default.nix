{
  config,
  lib,
  pkgs,
  ...
}:
{
  home.packages = with pkgs; [
    nvim-pkg
  ];
}
