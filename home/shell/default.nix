let
  shellAliases = {
    "vi" = "nvim";
    "et" = "emacs -nw";

    "rm" = "bash /home/enkai/flakes/lib/scripts/rm-to-trash.sh";
  };
in
{
  imports = [
    { _module.args = { inherit shellAliases; }; }

    ./fish
    ./nu
  ];
}
