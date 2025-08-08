{ pkgs, ... }:

{
  imports = [
    ./rofi.nix
    ./waybar.nix
  ];
  
  home.file."Pictures/wallpapers/default.jpg".source = ../../../wallpaper.png;

  home.file.".config/hypr/hyprland.conf".text = ''
    #monitor=HDMI-A-1,1920x1080@60,0x0,1
    exec-once = waybar &
    exec-once = swww init
    exec-once = swww img ~/Pictures/wallpapers/default.jpg
    exec-once = hyprlock &
    exec-once = nm-applet &
    exec-once = blueman-applet &
    
    input {
      kb_layout = us
      follow_mouse = 1
    }

    general {
      gaps_in = 5
      gaps_out = 10
      border_size = 2
      layout = dwindle
    }

    decoration {
      rounding = 10
      blur = true
      blur_size = 8
      blur_passes = 2
    }

    animations {
      enabled = true
      animation = windows,1,3,default
    }

    bind = SUPER, RETURN, exec, kitty
    bind = SUPER, Q, killactive,
    bind = SUPER, D, exec, rofi -show drun
    bind = SUPER, F, fullscreen
  '';
}
