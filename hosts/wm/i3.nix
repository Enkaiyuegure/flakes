{ pkgs, ... }:
{
  # i3 related options
  environment.pathsToLink = [ "/libexec" ]; # links /libexec from derivations to /run/current-system/sw 
  services = {
    xserver = {
      enable = true;

      desktopManager = {
        xterm.enable = false;
      };

      windowManager.i3 = {
        enable = true;
        extraPackages = with pkgs; [
          dunst # notification daemon
          i3lock # default i3 screen locker
          xautolock # lock screen after some time
          i3-gaps # i3 with gaps
          picom # transparency and shadows
          feh # set wallpaper
          acpi # battery information
          arandr # screen layout manager
          dex # autostart applications
          xbindkeys # bind keys to commands
          xorg.xbacklight # control screen brightness
          xorg.xdpyinfo # get screen information
          sysstat # get system information
          autotiling # automatically switch the horizontal / vertical window split orientation
        ];
      };

      # Configure keymap in X11
      xkb = {
        layout = "us";
        variant = "";
      };
    };

    displayManager = {
      defaultSession = "none+i3";
    };
  };

  # thunar file manager(part of xfce) related options
  programs.thunar.plugins = with pkgs.xfce; [
    thunar-archive-plugin
    thunar-volman
  ];
  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.tumbler.enable = true; # Thumbnail support for images
}
