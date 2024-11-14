{pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    desmume
    lime3ds
    ryujinx
  ];
}
