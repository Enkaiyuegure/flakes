{ userName, ... }:
{
  home = {
    username = "${userName}";
    homeDirectory = "/home/${userName}";
    language.base = "en_US.UTF-8";

    stateVersion = "24.05";
  };

  programs.home-manager.enable = true;
}
