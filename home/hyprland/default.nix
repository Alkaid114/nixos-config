{
  pkgs,
  config,
  ...
}: {
  imports = [
    ./hypridle.nix
    ./waybar.nix
  ];


  home.file.".config/hypr/hyprland.conf".text = ''
  exec-once = fcitx5 &
  exec-once = waybar &
  exec-once = mako &
  exec-once = cliphist &
  exec-once = nm-applet &
  exec-once = thunar &
  exec-once = hypridle &
  exec-once = hyprpaper &

  #monitor = HDMI-A-1, preferred, 165, 1.5


  bind = SUPER, Q, exec, wezterm
  bind = SUPER, R, exec, rofi -show drun
  bind = SUPER, L, exec, swaylock
  bind = SUPER, S, exec, grim -g "$(slurp)" - | swappy -f -

  general {
    gaps_in = 5
    gaps_out = 20
    border_size = 2
    layout = dwindle
  }

  input {
    kb_layout = us
    follow_mouse = 1
    sensitivity = 0.5
  }
'';


}