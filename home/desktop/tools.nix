{ pkgs, ... }:
{
  home.packages =
    with pkgs;
    [
      libreoffice
      mpv
      localsend
      piper
    ]
    ++ (with kdePackages; [
      okular
      gwenview
    ]);
}
