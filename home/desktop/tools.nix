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
    ]
    ++ (with kdePackages; [
      okular
      gwenview
    ]);
}
