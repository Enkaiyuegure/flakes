{ 
  config,
  pkgs-unstable,
  shellAliases,
  ...
}:
{
  programs.fish = {
    enable = true;
    package = pkgs-unstable.fish;
    inherit shellAliases;
  };
}
