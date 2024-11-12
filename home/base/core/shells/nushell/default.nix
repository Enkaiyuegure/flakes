{
  pkgs-unstable,
  config,
  shellAliases,
  ...
}: {
  programs.nushell = {
    enable = true;
    package = pkgs-unstable.nushell;
    configFile.source = ./config.nu;
    inherit shellAliases;
  };
}
