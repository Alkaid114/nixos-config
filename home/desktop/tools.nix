{ pkgs, ... }:
{
  home.packages =
    with pkgs;
    [
      libreoffice
      mpv
      localsend
      piper
      blender
    ]
    ++ (with kdePackages; [
      okular
      gwenview
    ]);
}
