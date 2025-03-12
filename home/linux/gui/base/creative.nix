{
  pkgs,
  pkgs-unstable,
  pkgs-stable,
  ...
}: let
  usefulIcons = {
    vivado = pkgs.fetchurl {
      url = "https://raw.githubusercontent.com/hmaarrfk/useful-icons/master/vivado-icons/vivado.png";
      hash = "sha256-QE1ee5PCDFQivjIzg5be7UoWEXY7EYkQDeXMXNFkqbg=";
    };
  };
  vivadoDesktop = pkgs.makeDesktopItem {
    name = "vivado";
    desktopName = "Vivado";
    icon = "${usefulIcons.vivado}";
    exec = "vivado";
    terminal = false;
  };
in {
  home.packages = with pkgs; [
    # creative
    pkgs-stable.blender # 3d modeling
    gimp # image editing
    inkscape # vector graphics
    krita # digital painting
    musescore # music notation
    reaper # audio production
    sonic-pi # music programming

    # 2d game design
    ldtk # A modern, versatile 2D level editor
    aseprite # Animated sprite editor & pixel art tool

    # this app consumes a lot of storage, so do not install it currently
    kicad # 3d printing, eletrical engineering

    # risc-v
    rars

    # matlab
    matlab
    matlab-shell
    matlab-mlint
    matlab-mex

    # fpga
    pkgs-unstable.python312Packages.apycula # gowin fpga
    pkgs-unstable.yosys # fpga synthesis
    pkgs-unstable.nextpnr # fpga place and route
    pkgs-unstable.openfpgaloader # fpga programming
    # nur-ryan4yin.packages.${pkgs.system}.gowin-eda-edu-ide # app: `gowin-env` => `gw_ide` / `gw_pack` / ...
    vivado-2020_1
    vivadoDesktop
  ];

  programs = {
    # live streaming
    obs-studio = {
      enable = true;
      plugins = with pkgs.obs-studio-plugins; [
        # screen capture
        wlrobs
        # obs-ndi
        obs-vaapi
        # obs-nvfbc
        obs-teleport
        # obs-hyperion
        # droidcam-obs
        obs-vkcapture
        obs-gstreamer
        obs-3d-effect
        input-overlay
        obs-multi-rtmp
        obs-source-clone
        obs-shaderfilter
        obs-source-record
        obs-livesplit-one
        looking-glass-obs
        obs-vintage-filter
        obs-command-source
        obs-move-transition
        obs-backgroundremoval
        # advanced-scene-switcher
        obs-pipewire-audio-capture
      ];
    };
  };
}
