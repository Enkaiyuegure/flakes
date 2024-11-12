{pkgs-stable, ...}: {
  home.packages = with pkgs-stable; [
    zotero
    calibre
  ];
}
