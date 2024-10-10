let
  shellAliases = {
    "vi" = "nvim";
    "et" = "emacs -nw";

    "rm" = "bash ~/Flakes/lib/scripts/rm-to-trash.sh";
    "clear-trash" = "sudo rm ~/.trash/* -r";

    "rebuild" = "sudo nixos-rebuild switch --flake ~/Flakes#";
    "change-build" = "bash ~/Flakes/lib/scripts/nix-rebuild.sh";

    "r" = "ranger";

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
