{
  config,
  lib,
  ...
}:
with lib; let
  cfg = config.home.linux.gui.hyprland;
in {
  options.home.linux.gui.hyprland = {
    nvidia = mkEnableOption "whether nvidia GPU is used";
  };

  config = mkIf (cfg.enable && cfg.nvidia) {
    wayland.windowManager.hyprland.settings.env = [
      # for hyprland with nvidia gpu, ref https://wiki.hyprland.org/Nvidia/
      "LIBVA_DRIVER_NAME,nvidia"
      "XDG_SESSION_TYPE,wayland"
      "GBM_BACKEND,nvidia-drm"
      # issue https://github.com/hyprwm/Hyprland/issues/7971
      "AQ_DRM_DEVICES,/dev/dri/card1"
      "__GLX_VENDOR_LIBRARY_NAME,nvidia"
      # fix https://github.com/hyprwm/Hyprland/issues/1520
      "WLR_NO_HARDWARE_CURSORS,1"
    ];
  };
}
