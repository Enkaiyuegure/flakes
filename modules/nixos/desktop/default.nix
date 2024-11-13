{
  pkgs,
  config,
  lib,
  myVars,
  myLib,
  ...
}:
with lib; let
  inherit (myVars) username;
in
{
  imports = (map myLib.relativeToModules [
    "nixos/base"
  ]) ++ (myLib.scanPaths ./.);

  options.modules.nixos.desktop = {
    xorg.enable = mkEnableOption "Xorg Display Server";
    wayland.enable = mkEnableOption "Wayland Display Server";
  };

  config = mkMerge [
    (mkIf config.modules.nixos.desktop.xorg.enable {
      #########################################
      # NixOS's Configuration for Xorg Server #
      #########################################

      services = {
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

    (mkIf config.modules.nixos.desktop.wayland.enable {
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
        xserver.enable = true; # disable xorg server
        xserver.displayManager.lightdm.enable = true;

        # https://wiki.archlinux.org/title/Greetd
        greetd = {
          enable = true;
          settings = {
            default_session = {
              user = username;
              command ="$HOME/.wayland-session";
            };
          };
        };
      };

      # fix https://github.com/ryan4yin/nix-config/issues/10
      security.pam.services.swaylock = {};
    })
  ];
}
