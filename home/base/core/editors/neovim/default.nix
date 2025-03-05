{pkgs, ...}: {
  programs = {
    neovim = {
      enable = false;

      defaultEditor = true;
      viAlias = true;
      vimAlias = true;
    };
  };
}
