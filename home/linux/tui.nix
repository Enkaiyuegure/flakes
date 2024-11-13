{myLib, ...}:
{
  imports = (map myLib.relativeToHome [
    "base/core"
    "base/tui"
    "base/home.nix"

    "linux/base"
  ]);
}
