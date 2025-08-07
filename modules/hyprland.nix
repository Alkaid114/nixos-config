{
  config,
  pkgs, 
  username,
  ...
}: {
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
    package = pkgs.hyprland;
  };

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";  # 修复 Electron 应用在 Wayland 下的问题
    WLR_NO_HARDWARE_CURSORS = "1";  # 某些显卡下鼠标显示异常可加此项
    XDG_CURRENT_DESKTOP = "Hyprland";
    QT_QPA_PLATFORM = "wayland";
    SDL_VIDEODRIVER = "wayland";
  };

  environment.systemPackages = with pkgs; [
    # 状态栏
    waybar

    # 通知系统
    mako

    # 应用启动器
    rofi-wayland

    # 终端
    wezterm

    # 输入法
    # fcitx5
    # fcitx5-gtk
    # fcitx5-qt
    # fcitx5-configtool
    # fcitx5-chinese-addons

    # 剪贴板
    wl-clipboard
    cliphist

    # 锁屏与待机
    # swaylock-effects
    hyprlock
    hypridle

    # 截图工具
    grim
    slurp
    swappy

    # 文件管理器
    thunar

    hyprpaper
  ];

  # 启用 D-Bus 和 Polkit（部分组件依赖）
  services.dbus.enable = true;
  services.polkit.enable = true;

  # 推荐使用 greetd + tuigreet 登录 Hyprland
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --user-menu --cmd Hyprland";
        user = username;
      };
    };
  };
}