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
    ]
    ++ (with kdePackages; [
      okular
      gwenview
    ]);
}
