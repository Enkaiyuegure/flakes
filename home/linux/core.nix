{myLib, ...}:
{
  imports = (map myLib.relativeToHome [
    "base/core"
    "base/home.nix"

    "linux/base"
  ]);
}
