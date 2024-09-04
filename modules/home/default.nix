{ myVars, ... }:
{
  home = {
    username = "${myVars.userName}";
    homeDirectory = "/home/${myVars.userName}";
    language.base = "en_US.UTF-8";

    stateVersion = "24.11";
  };

  programs.home-manager.enable = true;
}
