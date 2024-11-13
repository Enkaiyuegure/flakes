{myLib, myVars, config, ...}: let
  inherit (myVars) username;
  shellAliases = {
    k = "kubectl";

    urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
    urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";

    nix-eval = "nix eval /home/${username}/Flakes#evalTests --show-trace --print-build-logs --verbose";

    nh-switch = "bash /home/${username}/Flakes/scripts/nh-switch.sh";
    nh-boot = "bash /home/${username}/Flakes/scripts/nh-boot.sh";
    nh-test = "bash /home/${username}/Flakes/scripts/nh-test.sh";
    nh-build = "bash /home/${username}/Flakes/scripts/nh-build.sh";

    ga = "git add";
    gs = "git status";
  };

  localBin = "${config.home.homeDirectory}/.local/bin";
  goBin = "${config.home.homeDirectory}/go/bin";
  rustBin = "${config.home.homeDirectory}/.cargo/bin";
in {
  # only works in bash/fish, not nushell
  home.shellAliases = shellAliases;

  imports = (
    myLib.scanPaths ./.)
    ++ [
    {
      _module.args = {
        inherit shellAliases localBin goBin rustBin;
      };
    }
  ];
}
