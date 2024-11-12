{pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    desmume
  ];
}
