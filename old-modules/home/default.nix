{ myvars, ... }:
{
  home = {
    username = "${myvars.username}";
    homeDirectory = "/home/${myvars.username}";
    language.base = "en_US.UTF-8";

    stateVersion = "24.11";
  };

  programs.home-manager.enable = true;
}
