{
  pkgs,
  config,
  lib,
  myVars,
  ...
}: {
  options.modules.nixos.desktop.wm.gamescope.enable = lib.mkEnableOption "Gamescope Compositor";

  config = lib.mkIf config.modules.nixos.desktop.wm.gamescope.enable {
    programs.gamescope = {
      enable = true;
      capSysNice = true;
    };

    hardware.xone.enable = true;
    services.getty.autologinUser = "enkai";

    environment.systemPackages = with pkgs; [
      mangohud
    ];

    environment.loginShellInit = ''
      [[ "$(tty)" = "/dev/tty1" ]] && bash /home/${myVars.username}/Flakes/scripts/gamescope.sh
    '';
  };
}
