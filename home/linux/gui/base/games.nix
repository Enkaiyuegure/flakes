{
  pkgs,
  nix-gaming,
  ...
}: {
  # prettier-ignore
  home.packages = with pkgs; [
    # nix-gaming.packages.${pkgs.system}.osu-lazer-bin
    # gamescope # SteamOS session compositing window manager
    prismlauncher # A free, open source launcher for Minecraft
    winetricks # A script to install DLLs needed to work around problems in Wine

    okteta # A hex editor
    ghidra # A software reverse engineering (SRE) suite of tools 

    osu-lazer
  ];
}
