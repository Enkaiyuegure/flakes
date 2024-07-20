{ userName, ... }:
{
  home = {
    username = "${userName}";
    homeDirectory = "/home/${userName}";
    language.base = "en_US.UTF-8";

    stateVersion = "24.11";
  };

  programs.home-manager.enable = true;
}
