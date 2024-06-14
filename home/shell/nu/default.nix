{
  pkgs,
  lib,
  config,
  aliases,
  ...
}:
{
  options.shellAliases = with lib; mkOption {
    type = types.attrsOf types.str;
    default = {};
  };

  config.programs = {
    nushell = {
      shellAliases = aliases // config.shellAliases;
      enable = true;
    };
  };
}
