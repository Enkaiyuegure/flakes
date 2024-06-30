let
  shellAliases = {
    "vi" = "nvim";
    "et" = "emacs -nw";

    "rm" = "bash /home/enkai/flakes/lib/scripts/rm-to-trash.sh";

    # git
    "ga" = "git add";
    "gs" = "git status";
    "gc" = "git commit";

    # fun
    "n" = "fastfetch";
  };
in
{
  imports = [
    { _module.args = { inherit shellAliases; }; }

    ./fish
    ./nu
  ];
}
