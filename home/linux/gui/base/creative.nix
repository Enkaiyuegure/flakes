{
  pkgs,
  pkgs-unstable,
  ...
}: {
  home.packages = with pkgs; [
    # creative
    blender # 3d modeling
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

    # fpga
    pkgs-unstable.python312Packages.apycula # gowin fpga
    pkgs-unstable.yosys # fpga synthesis
    pkgs-unstable.nextpnr # fpga place and route
    pkgs-unstable.openfpgaloader # fpga programming
    # nur-ryan4yin.packages.${pkgs.system}.gowin-eda-edu-ide # app: `gowin-env` => `gw_ide` / `gw_pack` / ...

    # xilinx
    vivado
    vitis
    vitis_hls
    xilinx-shell
    petalinux-install-shell
    model_composer

    # matlab
    matlab
    matlab-shell
    matlab-mlint
    matlab-mex
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
