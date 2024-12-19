{pkgs, ...}: {
  home.packages = with pkgs; [
    # from https://fcitx-im.org/wiki/Using_Fcitx_5_on_Wayland#Chromium_.2F_Electron
    (obsidian.override {
      commandLineArgs = "--enable-features=UseOzonePlatform --ozone-platform=wayland --enable-wayland-ime";
    })
    obsidian-export
    zotero
    anytype
  ];
}
