{
  pkgs,
  config,
  lib,
  anyrun,
  ...
} @ args:
with lib; let
  cfg = config.home.linux.gui.hyprland;
  wallpapers = {
    nord = {
      url = "https://raw.githubusercontent.com/Enkaiyuegure/someSource/main/wall/nord.png";
      sha256 = "sha256-arMdIQOK6AMNu04nDPf/WirbpFnMMB+ja64gkjApY10=";
    };
  };
  default_wall = wallpapers.nord or (throw "Unknown theme");
  wallpaper = pkgs.fetchurl {
    inherit (default_wall) url sha256;
  };
in {
  imports = [
    anyrun.homeManagerModules.default
    ./options
  ];

  options.home.linux.gui.hyprland = {
    enable = mkEnableOption "hyprland compositor";
    settings = lib.mkOption {
      type = with lib.types; let
        valueType =
          nullOr (oneOf [
            bool
            int
            float
            str
            path
            (attrsOf valueType)
            (listOf valueType)
          ])
          // {
            description = "Hyprland configuration value";
          };
      in
        valueType;
      default = {};
    };
  };

  config = mkIf cfg.enable (
    mkMerge ([
        {
          wayland.windowManager.hyprland.settings = cfg.settings;
        }
      ]
      ++ (import ./values args))
  );
}
