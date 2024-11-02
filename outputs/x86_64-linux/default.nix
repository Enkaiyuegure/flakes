let
  directoryContents = builtins.readDir ./.;
  excludeDirs = [ ];
  directories = builtins.filter
    (name: directoryContents."${name}" == "directory" && !(builtins.elem name excludeDirs))
    (builtins.attrNames directoryContents);
  imports = map (name: ./. + "/${name}") directories;
in
{
  imports = imports;
}
