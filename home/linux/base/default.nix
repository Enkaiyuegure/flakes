{myLib, ...}: {
  imports = (map myLib.relativeToHome [
    "base/core"
    "base/tui"
    "base/gui"
    "base/home.nix"
  ]) ++ (myLib.scanPaths ./.);
}
