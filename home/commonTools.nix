{ pkgs, ... }:
{
  home.packages =
    with pkgs;
    [
      libreoffice
      vlc
      gparted
    ]
    ++ (with kdePackages; [
      kate
      okular
      gwenview
      filelight
    ]);
}
