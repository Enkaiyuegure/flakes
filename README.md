# Flakes
> Nix Flakes Configuration of Enkaiyuegure

**WIP**

The basic framework is derived from [`ryan4yin/nix-config`](https://github.com/ryan4yin/nix-config)

## Components

|                             | NixOS                                                    |
| --------------------------- | ---------------------------------------------------------|
| **Desktop Environment**     | [Gnome][Gnome], [Plasma][Plasma]                         |
| **Window Manager**          | [Mutter][Mutter], [KWin][Kwin], [Hyprland][Hyprland]     |
| **Terminal Emulator**       | [Kitty][Kitty], [Wezterm][Wezterm], [Kmscon][Kmscon]     |
| **Terminal Multiplexer**    | [Zellij][Zellij], [tmux][tmux]                           |
| **Shell**                   | [Nushell][Nushell], [Fish][Fish] + [Starship][Starship]  |
| **Status Bar**              | [Waybar][Waybar]                                         |
| **Application Launcher**    | [anyrun][anyrun]                                         |
| **Notification Daemon**     | [Mako][Mako]                                             |
| **Display Manager**         | [LightDM][LightDM]                                       |
| **Color Scheme**            | [Catppuccin][Catppuccin]                                 |
| **network management tool** | [NetworkManager][NetworkManager]                         |
| **Input method framework**  | [Fcitx5][Fcitx5]                                         |
| **System resource monitor** | [Btop][Btop]                                             |
| **File Manager**            | [Yazi][Yazi] + [thunar][thunar]                          | 
| **Streaming Music**         | [musicfox][musicfox], [YesPlayMusic][YesPlayMusic]       |
| **Music Player**            | [mpd][mpd], [ncmpcpp][ncmpcpp], [mpc][mpc]               |
| **Media Player**            | [mpv][mpv]                                               |
| **Image Viewer**            | [imv][imv]                                               |
| **Screenshot Software**     | [flameshot][flameshot] + [grim][grim]                    |
| **Screen Recording**        | [OBS][OBS]                                               |
| **Text Editor**             | [Neovim][Neovim], [Helix][Helix], [DoomEmacs][DoomEmacs] |
| **Fonts**                   | [Nerd fonts][Nerd fonts]                                 |
| **Filesystem**              | [Tmpfs][Tmpfs], [Btrfs][Btrfs], [LUKS][LUKS]             |
| **Boot Loader**             | [GRUB][GRUB]                                               | 


## TODO
- Docs: Add explanatory documents for each important directory
- Hosts:
  - Perhaps add more
  - Improve the management of system configuration
- Secrets:
  - Find an encryption solution for privacy information
  - Add a password store
  - Maybe a hardware key will better?
- Desktop Environment:
  - Gnome:
    - Refine the configuration declaratively using `dconf`
    - Manager extensions using Nix
  - KDE Plasma:
    - Unable to access the desktop, needs to be fixed
    - Manager configuration by [`plasma-manager`](https://github.com/nix-community/plasma-manager)
    - Set environment variables to allow changing WM:
      - Xorg: KWin, i3
      - Wayland: KWin, Hyprland, Niri
  - Comsic:
    - **WIP**
- Window Manager:
  - Hyprland: 
    - Modify some configurations
  - i3:
    - **WIP**
  - Niri:
    - **WIP**
- Terminal Emulator:
  - Wezterm:
    - Unable to start normally, pending fix
- Terminal Multiplexer:
  - tmux:
    - Refine the related settings
- Shell:
  - nushell:
    - Learn and configure further
  - fish:
    - same as above
- Status Bar:
  - Replace waybar with ags
- Input method:                                         |
  - Maybe I should try the double pinyin input method?
- **WIP**
    
[Gnome]: https://github.com/GNOME
[Plasma]: https://invent.kde.org/plasma/plasma-desktop
[Mutter]: https://gitlab.gnome.org/GNOME/mutter
[KWin]: https://invent.kde.org/plasma/kwin
[Hyprland]: https://github.com/hyprwm/Hyprland
[Kitty]: https://github.com/kovidgoyal/kitty
[Wezterm]: https://github.com/wez/wezterm
[Kmscon]: https://github.com/dvdhrm/kmscon
[Zellij]: https://github.com/zellij-org/zellij
[tmux]: https://github.com/tmux/tmux
[Nushell]: https://github.com/nushell/nushell
[Fish]: https://github.com/fish-shell/fish-shell
[Starship]: https://github.com/starship/starship
[Waybar]: https://github.com/Alexays/Waybar
[anyrun]: https://github.com/Kirottu/anyrun
[Mako]: https://github.com/emersion/mako
[LightDM]: https://github.com/canonical/lightdm
[Catppuccin]: https://github.com/catppuccin/catppuccin
[NetworkManager]: https://wiki.gnome.org/Projects/NetworkManager
[Fcitx5]: https://github.com/fcitx/fcitx5
[Btop]: https://github.com/aristocratos/btop
[Yazi]: https://github.com/sxyazi/yazi
[thunar]: https://gitlab.xfce.org/xfce/thunar
[musicfox]: https://github.com/go-musicfox/go-musicfox
[YesPlayMusic]: https://github.com/qier222/YesPlayMusic
[mpd]: https://github.com/MusicPlayerDaemon/MPD
[ncmpcpp]: https://github.com/ncmpcpp/ncmpcpp
[mpc]: https://github.com/MusicPlayerDaemon/mpc
[mpv]: https://github.com/mpv-player/mpv
[imv]: https://sr.ht/~exec64/imv/
[flameshot]: https://github.com/flameshot-org/flameshot
[grim]: https://github.com/emersion/grim
[OBS]: https://obsproject.com
[Neovim]: https://github.com/neovim/neovim
[Helix]: https://github.com/helix-editor/helix
[DoomEmacs]: https://github.com/doomemacs/doomemacs
[Nerd fonts]: https://github.com/ryanoasis/nerd-fonts
[Tmpfs]: https://wiki.archlinux.org/title/Tmpfs
[Btrfs]: https://btrfs.readthedocs.io
[LUKS]: https://wiki.archlinux.org/title/Dm-crypt/Encrypting_an_entire_system
[GRUB]: https://git.savannah.gnu.org/cgit/grub.git
