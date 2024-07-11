{ config
, pkgs
, ...
}: {
  imports = [
    ./browsers
    ./common.nix
    ./git.nix
    ./media.nix
    ./vscode.nix
    ./xdg.nix
    ./rofi
    ./fcitx5
  ];
}
