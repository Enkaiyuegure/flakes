{
  pkgs,
  ...
}: {
  home.packages = [pkgs.gh];

  programs.git = {
    enable = true;

    userName = "Enkaiyuegure";
    userEmail = "enkaiyuegure@outlook.com";
  };
}
