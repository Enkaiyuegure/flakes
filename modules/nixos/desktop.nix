{
  pkgs,
  config,
  lib,
  myVars,
  ...
}:
with lib; let
  inherit (myVars) username;
in
{
  imports = [
    #./base
    ../base

    ./desktop
  ];

  options.modules.desktop = {
    wayland = {
      enable = mkEnableOption "Wayland Display Server";
    };
    xorg = {
      enable = mkEnableOption "Xorg Display Server";
    };
  };

  config = mkMerge [
    (mkIf config.modules.desktop.wayland.enable {
      ##########################################################
      # NixOS's Configuration for Wayland based Window Manager #
      ##########################################################
      xdg.portal = {
        enable = true;
        wlr.enable = true;
        extraPortals = with pkgs; [
          xdg-desktop-portal-wlr
        ];
      };

      services = {
        xserver.enable = false; # disable xorg server
        # https://wiki.archlinux.org/title/Greetd
        greetd = {
          enable = true;
          settings = {
            default_session = {
              user = username;
            };
          };
        };
      };

      # fix https://github.com/ryan4yin/nix-config/issues/10
      security.pam.services.swaylock = {};
    })

    (mkIf config.modules.desktop.xorg.enable {
      #########################################
      # NixOS's Configuration for Xorg Server #
      #########################################

      services = {
        gvfs.enable = true; # Mount, trash, and other functionalities
        tumbler.enable = true; # Thumbnail support for images

        displayManager = {
          autoLogin = {
            enable = true;
            user = username;
          };
          # use a fake session to skip desktop manager
          # and let Home Manager take care of the X session
          defaultSession = "hm-session";
        };

        xserver = {
          enable = true;
          displayManager.lightdm.enable = true;
          desktopManager = {
            runXdgAutostartIfNone = true;
            session = [
              {
                name = "hm-session";
                manage = "window";
                start = ''
                  ${pkgs.runtimeShell} $HOME/.xsession &
                  waitPID=$!
                '';
              }
            ];
          };
          # Configure keymap in X11
          xkb.layout = "us";
        };
      };
    })
  ];
}
