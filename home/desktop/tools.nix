{ pkgs, ... }:
{
  home.packages =
    with pkgs;
    [
      libreoffice
      mpv
    ]
    ++ (with kdePackages; [
      okular
      gwenview
      filelight
    ]);
}
