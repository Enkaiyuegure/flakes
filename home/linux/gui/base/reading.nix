{pkgs, lib, ...}: {
  home.packages = with pkgs; [
    (lib.hiPrio zotero)
    calibre
  ];
}
