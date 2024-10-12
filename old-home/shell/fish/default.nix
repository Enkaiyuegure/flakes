{ config, shellAliases, ... }:
{
  programs.fish = {
    enable = true;
    loginShellInit = ''
        set TTY1 (tty)
        [ "$TTY1" = "/dev/tty1" ] && exec i3
      '';
    interactiveShellInit = ''
      set fish_greeting ""
      set fish_key_bindings  fish_vi_key_bindings
    '';
    inherit shellAliases;

    functions = {
      f = ''
        FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git' FZF_DEFAULT_OPTS="--color=bg+:#4C566A,bg:#424A5B,spinner:#F8BD96,hl:#F28FAD  --color=fg:#D9E0EE,header:#F28FAD,info:#DDB6F2,pointer:#F8BD96  --color=marker:#F8BD96,fg+:#F2CDCD,prompt:#DDB6F2,hl+:#F28FAD --preview 'bat --style=numbers --color=always --line-range :500 {}'" fzf --height 60% --layout reverse --info inline --border --color 'border:#b48ead'
      '';
    };
  };
  home.file = {
    ".config/fish/conf.d/nord.fish".text = import ./nord_theme.nix;
    ".config/fish/functions/fish_prompt.fish".source = ./functions/fish_prompt.fish;
    ".config/fish/functions/xdg-get.fish".text = import ./functions/xdg-get.nix;
    ".config/fish/functions/xdg-set.fish".text = import ./functions/xdg-set.nix;
    ".config/fish/functions/owf.fish".text = import ./functions/owf.nix;
  };
}
