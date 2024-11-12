{myLib, config, ...}: let
  shellAliases = {
    k = "kubectl";

    urldecode = "python3 -c 'import sys, urllib.parse as ul; print(ul.unquote_plus(sys.stdin.read()))'";
    urlencode = "python3 -c 'import sys, urllib.parse as ul; print(ul.quote_plus(sys.stdin.read()))'";
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
