{
  pkgs,
  config,
  ...
}: {
  home.file.".config/rofi" = {
    source = ./configs;
    recursive = true;
  };
}
