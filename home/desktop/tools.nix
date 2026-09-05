{ pkgs, ... }:
{
  home.packages =
    with pkgs;
    [
      libreoffice
      mpv
      localsend
    ]
    ++ (with kdePackages; [
      okular
      gwenview
      filelight
    ]);
}
