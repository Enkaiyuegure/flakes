let
  shellAliases = {
    "vi" = "nvim";
    "et" = "emacs -nw"
  };
in
{
  imports = [
    { _module.args = { inherit shellAliases; }; }

    ./fish
    ./nu
  ];
}
