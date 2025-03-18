{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    clash-nyanpasu
  ];
}
