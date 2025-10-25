{ pkgs, ... }:
{
  home.packages =
    with pkgs;
    [
      libreoffice
      vlc
      gparted
      swww  # Wayland 壁纸设置工具
    ]
    ++ (with kdePackages; [
      kate
      okular
      gwenview
      filelight
    ]);
}
