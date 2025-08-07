{
  config,
  pkgs,
  ...
}: {
  home.file.".config/hypr/hypridle.conf".text = ''
    # 10 分钟后锁屏
    timeout = 600, lock
    on-timeout = hyprlock
    on-resume = notify-send "欢迎回来！"

    # 10 分钟后关闭屏幕
    timeout = 600, dpms
    on-timeout = hyprctl dispatch dpms off
    on-resume = hyprctl dispatch dpms on
  '';
}