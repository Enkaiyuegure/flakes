{
  pkgs,
  lib,
  config,
  ...
}: {
  options.modules.nixos.desktop.gnome = {
    enable = lib.mkEnableOption "Gnome Desktop Environment";
  };

  config = lib.mkIf config.modules.nixos.desktop.gnome.enable {
    environment = {
      systemPackages = with pkgs; [
        morewaita-icon-theme
        qogir-icon-theme
        gnome-extension-manager
        wl-clipboard
      ];

      gnome.excludePackages =
        (with pkgs; [
          # gnome-text-editor
          gnome-console
          gnome-photos
          gnome-tour
          gnome-connections
          snapshot
          gedit
          cheese # webcam tool
          epiphany # web browser
          geary # email reader
          evince # document viewer
          totem # video player
          yelp # Help view
          gnome-font-viewer
          gnome-music
          gnome-characters
          tali # poker game
          iagno # go game
          hitori # sudoku game
          atomix # puzzle game
          gnome-contacts
          gnome-initial-setup
          gnome-shell-extensions
          gnome-maps
        ]);
    };

    services.xserver.desktopManager.gnome.enable = true;

    programs.dconf.profiles.gdm.databases = [
      {
        settings = {
          "org/gnome/desktop/peripherals/touchpad" = {
            tap-to-click = true;
          };
          "org/gnome/desktop/interface" = {
            cursor-theme = "Qogir";
          };
        };
      }
    ];
  };
}
