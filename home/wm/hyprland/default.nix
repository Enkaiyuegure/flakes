{
  imports = [
    ./config.nix
  ];

  wayland.windowManager.hyprland.enable = true;

  home.file.".config/hypr/scripts" = {
    source = ./scripts;
    recursive = true;
    executable = true;
  };
}
