{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    polybarFull
  ];
}
