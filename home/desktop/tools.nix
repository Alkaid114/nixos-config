{ pkgs, ... }:
{
  home.packages =
    with pkgs;
    [
      libreoffice
      mpv
      vlc
      localsend
      piper
      blender
      qbittorrent
    ]
    ++ (with kdePackages; [
      okular
      gwenview
    ]);
}
