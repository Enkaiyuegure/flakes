{
  pkgs,
  hyprland,
  config,
  asztal,
  lib,
  ...
}: {
  options.modules.nixos.desktop.wm.hyprland.enable = lib.mkEnableOption "Hyprland Window Manager";

  config = lib.mkIf config.modules.nixos.desktop.wm.hyprland.enable {
    programs.hyprland = {
      enable = true;
      package = hyprland.packages.${pkgs.system}.hyprland;
      xwayland.enable = true;
    };

    environment.systemPackages = with pkgs; [
      morewaita-icon-theme
      adwaita-icon-theme
      qogir-icon-theme
      loupe
      nautilus
      baobab
      gnome-text-editor
      gnome-calendar
      gnome.gnome-boxes
      gnome-system-monitor
      gnome.gnome-control-center
      gnome.gnome-weather
      gnome-calculator
      gnome.gnome-clocks
      gnome.gnome-software # for flatpak
      wl-gammactl
      wl-clipboard
      wayshot
      pavucontrol
      brightnessctl
      swww
    ];

    systemd = {
      user.services.polkit-gnome-authentication-agent-1 = {
        description = "polkit-gnome-authentication-agent-1";
        wantedBy = ["graphical-session.target"];
        wants = ["graphical-session.target"];
        after = ["graphical-session.target"];
        serviceConfig = {
          Type = "simple";
          ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
          Restart = "on-failure";
          RestartSec = 1;
          TimeoutStopSec = 10;
        };
      };
    };

    services.gnome = {
      evolution-data-server.enable = true;
      glib-networking.enable = true;
      gnome-keyring.enable = true;
      gnome-online-accounts.enable = true;
      tracker-miners.enable = true;
      tracker.enable = true;
    };

    #    services.greetd = {
    # settings.default_session.command = pkgs.writeShellScript "greeter" ''
    #        export XKB_DEFAULT_LAYOUT=${config.services.xserver.xkb.layout}
    #   export XCURSOR_THEME=Qogir
    #   ${asztal}/bin/greeter
    # '';
    #  };

    #  systemd.tmpfiles.rules = [
    #  "d '/var/cache/greeter' - greeter greeter - -"
    #  ];
  };
}
