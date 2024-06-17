{
  pkgs,
  config,
  ...
}:
{
  home.file = {
    ".config/i3/wallpaper.jpg".source = ../../wallpaper.jpg;
    ".config/i3/config".source = ./config;
    ".config/i3/i3blocks.conf".source = ./i3blocks.conf;
    ".config/i3/keybindings".source = ./keybindings;
    ".config/i3/scripts" = {
      source = ./scripts;
      recursive = true;
      executable = true;
    };
  };
}
