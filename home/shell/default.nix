let
  aliases = {
    "vi" = "nvim";
  };
in
{
  imports = [
    { _module.args = { inherit aliases; }; }

    ./nu
  ];
}
