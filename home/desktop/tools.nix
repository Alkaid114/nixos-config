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
      gimp
      evtest
    ]
    ++ (with kdePackages; [
      okular
      gwenview
    ]);
}
