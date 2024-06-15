let
  shellAliases = {
    "vi" = "nvim";
  };
in
{
  imports = [
    { _module.args = { inherit shellAliases; }; }

    ./nu
  ];
}
