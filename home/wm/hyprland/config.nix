{ pkgs, config, lib, ... }:
{
  wayland.windowManager.hyprland = {
    extraConfig = ''
      # $scripts=$HOME/.config/hypr/scripts

      #monitor=,preferred,auto,1 
      monitor=eDP-1, 2560x1440@120, 0x0, 1
      monitor=DP-1, 2560x1600@120, 2560x0, 1
      monitor=HDMI-A-1, 3840x2160@60, 5120x0, 1


      # Source a file (multi-file configs)
      # source = ~/.config/hypr/myColors.conf

      input {
        kb_layout = us
        kb_variant =
        kb_model =
        kb_options = caps:escape
        kb_rules =

        follow_mouse = 1 # 0|1|2|3
        float_switch_override_focus = 2
        numlock_by_default = true

        touchpad {
        natural_scroll = yes
        }

        sensitivity = 0 # -1.0 - 1.0, 0 means no modification.
      }

      general {
        gaps_in = 3
        gaps_out = 5
        border_size = 3
        col.active_border = rgb(81a1c1)
        col.inactive_border = rgba(595959aa)

        layout = dwindle # master|dwindle 
      }

      dwindle {
        no_gaps_when_only = false
        force_split = 0 
        special_scale_factor = 0.8
        split_width_multiplier = 1.0 
        use_active_for_splits = true
        pseudotile = yes 
        preserve_split = yes 
      }

      master {
        new_is_master = true
        special_scale_factor = 0.8
        new_is_master = true
        no_gaps_when_only = false
      }

      # cursor_inactive_timeout = 0
      decoration {
        rounding = 0
        active_opacity = 1.0
        inactive_opacity = 1.0
        fullscreen_opacity = 1.0
        drop_shadow = false
        shadow_range = 4
        shadow_render_power = 3
        shadow_ignore_window = true
      # col.shadow = 
      # col.shadow_inactive
      # shadow_offset
        dim_inactive = false
      # dim_strength = #0.0 ~ 1.0
        col.shadow = rgba(1a1a1aee)

          blur {
              enabled = true
              size = 3
              passes = 1
              new_optimizations = true
              xray = true
              ignore_opacity = false
          }
      }

      animations {
        enabled=1
        bezier = overshot, 0.13, 0.99, 0.29, 1.1
        animation = windows, 1, 4, overshot, slide
        animation = windowsOut, 1, 5, default, popin 80%
        animation = border, 1, 5, default
        animation = fade, 1, 8, default
        animation = workspaces, 1, 6, overshot, slidevert
      }

      gestures {
        workspace_swipe = true
        workspace_swipe_fingers = 4
        workspace_swipe_distance = 250
        workspace_swipe_invert = true
        workspace_swipe_min_speed_to_force = 15
        workspace_swipe_cancel_ratio = 0.5
        workspace_swipe_create_new = false
      }

      misc {
        disable_autoreload = true
        disable_hyprland_logo = true
        always_follow_on_dnd = true
        layers_hog_keyboard_focus = true
        animate_manual_resizes = false
        enable_swallow = true
        swallow_regex =
        focus_on_activate = true
      }


      bind = Super, Return, exec, kitty
      bind = Super SHIFT, Return, exec, kitty --class="termfloat"
      bind = Alt, Q, killactive,
      bind = Super SHIFT, Q, exit,
      bind = Super SHIFT, Space, togglefloating,
      bind = Alt,F,fullscreen
      bind = Alt,Y,pin
      bind = Super, P, pseudo, # dwindle
      bind = Super, J, togglesplit, # dwindle

      #-----------------------#
      # Toggle grouped layout #
      #-----------------------#
      bind = Super, K, togglegroup,
      bind = Alt, Tab, changegroupactive, f

      #------------#
      # change gap #
      #------------#
      bind = Super SHIFT, G,exec,hyprctl --batch "keyword general:gaps_out 5;keyword general:gaps_in 3"
      bind = Super , G,exec,hyprctl --batch "keyword general:gaps_out 0;keyword general:gaps_in 0"

      #--------------------------------------#
      # Move focus with mainMod + arrow keys #
      #--------------------------------------#
      bind = Alt, left, movefocus, l
      bind = Alt, right, movefocus, r
      bind = Alt, up, movefocus, u
      bind = Alt, down, movefocus, d

      #----------------------------------------#
      # Switch workspaces with mainMod + [0-9] #
      #----------------------------------------#
      bind = Super, 1, workspace, 1
      bind = Super, 2, workspace, 2
      bind = Super, 3, workspace, 3
      bind = Super, 4, workspace, 4
      bind = Super, 5, workspace, 5
      bind = Super, 6, workspace, 6
      bind = Super, 7, workspace, 7
      bind = Super, 8, workspace, 8
      bind = Super, 9, workspace, 9
      bind = Super, 0, workspace, 10
      bind = Super, L, workspace, +1
      bind = Super, H, workspace, -1
      bind = Super, right, workspace, e+1
      bind = Super, left, workspace,e-1
      bind = Super, T, workspace,TG
      bind = Super, M, workspace,Music

      #-------------------------------#
      # special workspace(scratchpad) #
      #-------------------------------# 
      bind = Super, minus, movetoworkspace,special
      bind = Super, equal, togglespecialworkspace

      #----------------------------------#
      # move window in current workspace #
      #----------------------------------#
      bind = Super SHIFT,left ,movewindow, l
      bind = Super SHIFT,right ,movewindow, r
      bind = Super SHIFT,up ,movewindow, u
      bind = Super SHIFT,down ,movewindow, d

      #---------------------------------------------------------------#
      # Move active window to a workspace with mainMod + ctrl + [0-9] #
      #---------------------------------------------------------------#
      bind = Super CTRL, 1, movetoworkspace, 1
      bind = Super CTRL, 2, movetoworkspace, 2
      bind = Super CTRL, 3, movetoworkspace, 3
      bind = Super CTRL, 4, movetoworkspace, 4
      bind = Super CTRL, 5, movetoworkspace, 5
      bind = Super CTRL, 6, movetoworkspace, 6
      bind = Super CTRL, 7, movetoworkspace, 7
      bind = Super CTRL, 8, movetoworkspace, 8
      bind = Super CTRL, 9, movetoworkspace, 9
      bind = Super CTRL, 0, movetoworkspace, 10
      bind = Super CTRL, left, movetoworkspace, -1
      bind = Super CTRL, right, movetoworkspace, +1
      # same as above, but doesnt switch to the workspace
      bind = Super SHIFT, 1, movetoworkspacesilent, 1
      bind = Super SHIFT, 2, movetoworkspacesilent, 2
      bind = Super SHIFT, 3, movetoworkspacesilent, 3
      bind = Super SHIFT, 4, movetoworkspacesilent, 4
      bind = Super SHIFT, 5, movetoworkspacesilent, 5
      bind = Super SHIFT, 6, movetoworkspacesilent, 6
      bind = Super SHIFT, 7, movetoworkspacesilent, 7
      bind = Super SHIFT, 8, movetoworkspacesilent, 8
      bind = Super SHIFT, 9, movetoworkspacesilent, 9
      bind = Super SHIFT, 0, movetoworkspacesilent, 10
      # Scroll through existing workspaces with mainMod + scroll
      bind = Super, mouse_down, workspace, e+1
      bind = Super, mouse_up, workspace, e-1

      #-------------------------------------------#
      # switch between current and last workspace #
      #-------------------------------------------#
      binds {
           workspace_back_and_forth = 1 
           allow_workspace_cycles = 1
      }
      bind=Super,slash,workspace,previous

      #------------------------#
      # quickly launch program #
      #------------------------# 
      bind=Super,B,exec,nvidia-offload firefox
      bind=Super,M,exec,kitty --class="musicfox" --hold sh -c "musicfox" 
      bind=Super,q,exec, qq --enable-features=UseOzonePlatform --ozone-platform=x11

      #-----------------------------------------#
      # control volume,brightness,media players-#
      #-----------------------------------------#
      bind=,XF86AudioRaiseVolume,exec, pamixer -i 5
      bind=,XF86AudioLowerVolume,exec, pamixer -d 5
      bind=,XF86AudioMute,exec, pamixer -t
      bind=,XF86AudioMicMute,exec, pamixer --default-source -t
      bind=,XF86MonBrightnessUp,exec, light -A 5
      bind=,XF86MonBrightnessDown, exec, light -U 5
      bind=,XF86AudioPlay,exec, mpc -q toggle 
      bind=,XF86AudioNext,exec, mpc -q next 
      bind=,XF86AudioPrev,exec, mpc -q prev

      #-----#
      # ags #
      #-----#
      exec-once = ags -b hypr

      #---------------#
      # resize window #
      #---------------#
      bind=ALT,R,submap,resize
      submap=resize
      binde=,right,resizeactive,15 0
      binde=,left,resizeactive,-15 0
      binde=,up,resizeactive,0 -15
      binde=,down,resizeactive,0 15
      binde=,l,resizeactive,15 0
      binde=,h,resizeactive,-15 0
      binde=,k,resizeactive,0 -15
      binde=,j,resizeactive,0 15
      bind=,escape,submap,reset 
      submap=reset

      bind=CTRL SHIFT, left, resizeactive,-15 0
      bind=CTRL SHIFT, right, resizeactive,15 0
      bind=CTRL SHIFT, up, resizeactive,0 -15
      bind=CTRL SHIFT, down, resizeactive,0 15
      bind=CTRL SHIFT, l, resizeactive, 15 0
      bind=CTRL SHIFT, h, resizeactive,-15 0
      bind=CTRL SHIFT, k, resizeactive, 0 -15
      bind=CTRL SHIFT, j, resizeactive, 0 15

      bindm = Super, mouse:272, movewindow
      bindm = Super, mouse:273, resizewindow

      #-----------------------#
      # wall(by swww service) #
      #-----------------------#
      # exec-once = default_wall 

      #------------#
      # auto start #
      #------------#
      exec-once = mako &
      exec-once = nm-applet &

      #---------------#
      # windows rules #
      #---------------#
      #`hyprctl clients` get class、title...
      windowrule=float,title:^(Picture-in-Picture)$
      windowrule=size 960 540,title:^(Picture-in-Picture)$
      windowrule=move 25%-,title:^(Picture-in-Picture)$
      windowrule=float,imv
      windowrule=move 25%-,imv
      windowrule=size 960 540,imv
      windowrule=float,mpv
      windowrule=move 25%-,mpv
      windowrule=size 960 540,mpv
      windowrule=float,danmufloat
      windowrule=move 25%-,danmufloat
      windowrule=pin,danmufloat
      windowrule=rounding 5,danmufloat
      windowrule=size 960 540,danmufloat
      windowrule=float,termfloat
      windowrule=move 25%-,termfloat
      windowrule=size 960 540,termfloat
      windowrule=rounding 5,termfloat
      windowrule=float,nemo
      windowrule=move 25%-,nemo
      windowrule=size 960 540,nemo
      windowrule=opacity 0.95,title:Telegram
      windowrule=animation slide right,kitty
      windowrule=workspace name:TG, title:Telegram
      windowrule=workspace name:Music, musicfox
      windowrule=float,ncmpcpp
      windowrule=move 25%-,ncmpcpp
      windowrule=size 960 540,ncmpcpp
      windowrule=noblur,^(firefox)$

      #-----------------#
      # workspace rules #
      #-----------------#
      workspace=HDMI-A-1,10
    '';
  };
}
