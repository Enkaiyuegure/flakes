{ pkgs, ... }: {
  home.packages = with pkgs; [
    # archives
    zip
    unzip
    p7zip

    # utils
    ripgrep
    yq-go # https://github.com/mikefarah/yq
    htop

    # fun
    fastfetch
    go-musicfox
    prismlauncher

    # communication
    qq
    thunderbird

    #dev
    #cs
    kubernetes
    k9s
    kubectl

    gdb

    mitscheme

    zulu

    nodejs_22
    nodePackages_latest.gatsby-cli
    hugo

    # Jetbrains
    jetbrains.clion
    jetbrains.goland
    jetbrains.idea-ultimate
    jetbrains.pycharm-professional
    jetbrains.webstorm

    #ee
    kicad
    ngspice
    freecad
    librecad
    scilab-bin
    nasm
    platformio
  ];

  programs = {
    bat = {
      enable = true;
      config = {
        pager = "less -FR";
      };
    };

    btop.enable = true; # replacement of htop/nmon
    eza.enable = true; # A modern replacement for ‘ls’
    jq.enable = true; # A lightweight and flexible command-line JSON processor
    ssh.enable = true;
    aria2.enable = true;

    skim = {
      enable = true;
      enableZshIntegration = true;
      defaultCommand = "rg --files --hidden";
      changeDirWidgetOptions = [
        "--preview 'exa --icons --git --color always -T -L 3 {} | head -200'"
        "--exact"
      ];
    };
  };

  services = {
    syncthing.enable = true;

    # auto mount usb drives
    udiskie.enable = true;
  };
}
