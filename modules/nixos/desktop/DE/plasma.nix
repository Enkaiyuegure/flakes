{
  pkgs,
  lib,
  config,
  ...
}: {
  options.modules.nixos.desktop.de.kde.enable = lib.mkEnableOption "KDE Plasma Desktop Environment";

  config = lib.mkIf config.modules.nixos.desktop.de.kde.enable {
    environment.plasma6.excludePackages = with pkgs.kdePackages; [
      plasma-browser-integration
      konsole
      oxygen
    ];

    services.desktopManager.plasma6.enable = true;

    qt = {
      enable = true;
      platformTheme = "gnome";
      style = "adwaita-dark";
    };
  };
}
