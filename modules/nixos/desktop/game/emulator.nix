{pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    desmume
    melonDS
    # lime3ds
    ryujinx
  ];
}
