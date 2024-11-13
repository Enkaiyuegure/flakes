{myLib, ...}: {
  imports = (map myLib.relativeToModules [
    "base"
  ]) ++ (myLib.scanPaths ./.);
}
