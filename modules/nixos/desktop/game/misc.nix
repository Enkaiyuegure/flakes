{pkgs, ...}:
{
  environment.systemPackages = with pkgs; [
    nexusmods-app-unfree
  ];
}
