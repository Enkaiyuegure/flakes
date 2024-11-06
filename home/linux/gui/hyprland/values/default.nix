{myLib, ...} @ args:
map
(path: import path args)
(myLib.scanPaths ./.)
