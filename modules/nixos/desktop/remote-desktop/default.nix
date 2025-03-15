{
  pkgs,
  pkgs-stable,
  myLib,
  ...
}: {
  # imports = myLib.scanPaths ./.;
  #
  environment.systemPackages = with pkgs; [
    waypipe
    moonlight-qt # moonlight client, for streaming games/desktop from a PC
    pkgs-stable.rustdesk # p2p remote desktop
  ];
}
