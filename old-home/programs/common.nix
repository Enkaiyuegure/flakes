{ pkgs, ... }: {
  home.packages = with pkgs; [
    # utils
    ripgrep
    yq-go # https://github.com/mikefarah/yq
    htop
    pandoc

    # fun
    go-musicfox
    prismlauncher
    discord
    moonlight-qt

    #AI
    ollama
    koboldcpp

    # communication
    qq
    thunderbird
    telegram-desktop
    tg

    #dev
    #cs
    kubernetes
    k9s
    kubectl

    zulu

    # Jetbrains
    #jetbrains.clion
    #jetbrains.goland
    #jetbrains.idea-ultimate
    #jetbrains.pycharm-professional
    #jetbrains.webstorm

    #ee
    #kicad
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
