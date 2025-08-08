{pkgs,config,...}:
{
  imports = [
  ];
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;  # 如果你需要运行 X 应用
  };

  # SDDM 图形登录界面
  services.xserver.enable = true;
  services.displayManager.sddm.enable = true;

  # 推荐启用的一些服务
  services.gvfs.enable = true;  # 文件挂载支持
  security.polkit.enable = true;
  xdg.portal.enable = true;
  xdg.portal.extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];

  services.blueman.enable = true;


  security.pam.services.swaylock = {};
  security.pam.services.hyprlock = {};

  # environment.sessionVariables = {
  #   XDG_SESSION_TYPE = "wayland";
  #   GDK_BACKEND = "wayland";
  #   QT_QPA_PLATFORM = "wayland";
  #   SDL_VIDEODRIVER = "wayland";
  #   CLUTTER_BACKEND = "wayland";
  # };


  environment.systemPackages = with pkgs; [
    hyprland
    waybar
    kitty
    wlogout
    # swaylock-effects
    rofi-wayland
    swww              # 壁纸工具
    # hyprlock          # 锁屏器
    networkmanager
    networkmanagerapplet  # nm-applet 图标
    blueman           # 蓝牙管理器
  ] ++ (with kdePackages; 
  [
    dolphin
  ]);

}