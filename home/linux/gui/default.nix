{myLib, ...}: {
  imports = (map myLib.relativeToHome [
    "linux/base"
  ]) ++ (myLib.scanPaths ./.);
}
